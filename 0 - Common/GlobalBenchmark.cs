using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

public class GlobalBenchmark : MonoBehaviour
{
    public GameObject[] Meshes;
	public string[] Header;
	public fps fps;
	public Camera CameraInstance;

	public int Count = 8;
	public float DistanceBetweenInstances = 1.0f;
	public float BenchmarkTime = 180;
	public string FileName = "Hello.txt";
	private int _index;
	private Dictionary<string, double> _result;
	private GameObject[] _instances;


    void Start()
    {
		fps.Prefix = "Benchmark starts in 15 seconds";
		_index = 0;
		_result = new Dictionary<string, double>();
		_instances = new GameObject[Count * Count];
		
		if (CameraInstance != null )
		{
			CameraInstance.transform.position = new Vector3(Count * DistanceBetweenInstances / 2.0f, 0.5f, Count * DistanceBetweenInstances / 2.0f);
			CameraInstance.orthographicSize = Count * DistanceBetweenInstances / 2.0f;
		}

		foreach (var mesh in Meshes)
		{
			mesh.SetActive(false);
		}
		Invoke(nameof(StartBenchmark), 15f); //Gives enough time for everything to settle

	}

	private void StartBenchmark()
	{
		Benchmark();
	}

	private void Benchmark()
	{
		Meshes[_index].SetActive(true);
		for (int x = 0; x < Count; x++)
		{
			for (int y = 0; y < Count; y++)
			{
				_instances[x * Count + y] = Instantiate(Meshes[_index]);
				_instances[x * Count + y].transform.position = new Vector3(x * DistanceBetweenInstances, 0, y * DistanceBetweenInstances) 
															+ new Vector3(DistanceBetweenInstances / 2.0f, 0, DistanceBetweenInstances / 2.0f);
			}
		}
		
		fps.Prefix = Header[_index].ToString();
		fps.Restart();
		Invoke(nameof(FinishBenchmark), BenchmarkTime);
	}

	private void FinishBenchmark()
	{
		foreach (var instance in _instances)
		{
			DestroyImmediate(instance);
		}
		Meshes[_index].SetActive(false);
		_result[Header[_index]] = fps.GetFPS();
		_index++;
		if (_index == Meshes.Length)
		{
			End();
		}
		else
		{
			Benchmark();
		}
	}

	private void End()
    {
		string projectPath = Application.dataPath + "/../";
		string fullPath = Path.Combine(projectPath, FileName);
		Debug.Log(fullPath);
		using (StreamWriter writer = new StreamWriter(fullPath))
		{
			foreach (var pair in _result)
			{
				writer.WriteLine($"{pair.Key}; {pair.Value}");
			}
		}
	}
}
