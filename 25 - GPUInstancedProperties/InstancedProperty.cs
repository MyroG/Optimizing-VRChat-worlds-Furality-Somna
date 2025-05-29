using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InstancedProperty : MonoBehaviour
{
	public Transform Parent;
	public GameObject ToInstantiate;

	public int Size = 50;

	void Start()
	{
		// Instanced property example
		for (int x = 0; x < Size; x++)
		{
			for (int z = 0; z < Size; z++)
			{
				GameObject instantiated = Instantiate(ToInstantiate);
				instantiated.transform.parent = Parent;
				instantiated.transform.localPosition = new Vector3(x * 1.5f, 0, z * 1.5f);
				MeshRenderer meshRenderer = instantiated.GetComponent<MeshRenderer>();

				MaterialPropertyBlock mpb  = new MaterialPropertyBlock();
				mpb.SetFloat("_hue", Random.Range(0.0f, 1));
				meshRenderer.SetPropertyBlock(mpb);

				//This line doesn't work, it breaks batching!!
				//meshRenderer.material.SetFloat("_hue", Random.Range(0.0f, 1));
			}
		}
	}
}
