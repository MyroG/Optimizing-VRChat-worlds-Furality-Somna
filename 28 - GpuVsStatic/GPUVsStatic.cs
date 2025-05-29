using System.Collections;
using System.Collections.Generic;
using System.Drawing;
using Unity.Transforms;
using UnityEngine;

public class GPUVsStatic : MonoBehaviour
{
	public int Size;
	public DrawInstanced instancedRenderer;
	public GameObject ToInstantiate;
	public GameObject Parent;
	public fps fps;

	private GameObject[] _instantiated;
	void Start()
	{
		fps.Prefix = "GPU Instanced";
		_instantiated = new GameObject[Size * Size];
		int index = 0;
		for (int i = 0; i < Size; i++)
		{
			for (int j = 0; j < Size; j++)
			{
				GameObject instantiated = Instantiate(ToInstantiate);
				instantiated.transform.localPosition = new Vector3(i * 0.7f, 0, j * 0.7f);
				instantiated.transform.parent = Parent.transform;
				instantiated.isStatic = true;
				instantiated.SetActive(true);

				_instantiated[index] = instantiated;
				index++;
			}
		}

		Invoke(nameof(StaticBatch), 20f);
	}

	private void StaticBatch()
	{
		StaticBatchingUtility.Combine(Parent);
		fps.Prefix = "Static batching";
		fps.Restart();

		Invoke(nameof(Manual), 20f);
	}

	private void Manual()
	{
		fps.Prefix = "DrawMeshInstanced";
		Parent.gameObject.SetActive(false);
		instancedRenderer.AreaSize = Size;
		instancedRenderer.gameObject.SetActive(true);
		fps.Restart();
	}
}
