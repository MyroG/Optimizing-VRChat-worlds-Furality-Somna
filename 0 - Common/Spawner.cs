using System.Collections;
using System.Collections.Generic;
using System.Drawing;
using Unity.Transforms;
using UnityEngine;

public class Spawner : MonoBehaviour
{
	public GameObject Instance;
	public int Size;
	public Transform Parent;
	public float Distance = 1.5f;
    void Start()
    {
		for (int x = 0; x < Size; x++)
		{
			for (int z = 0; z < Size; z++)
			{
				GameObject instantiated = Instantiate(Instance);
				instantiated.transform.parent = Parent;
				instantiated.transform.localPosition = new Vector3(x * Distance, 0, z * Distance);
			}
		}
	}
}
