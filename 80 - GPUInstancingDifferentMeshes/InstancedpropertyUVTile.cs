using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InstancedpropertyUVTile : MonoBehaviour
{
	public Transform Parent;
	public GameObject ToInstantiate;

	public int Size = 50;

	void Start()
	{
		// Instanced property example with a UV tile discard system
		for (int x = 0; x < Size; x++)
		{
			for (int z = 0; z < Size; z++)
			{
				GameObject instantiated = Instantiate(ToInstantiate);
				instantiated.transform.parent = Parent;
				instantiated.transform.localPosition = new Vector3(x * 3f, 0, z * 3f);
				MeshRenderer meshRenderer = instantiated.GetComponent<MeshRenderer>();

				MaterialPropertyBlock mpb = new MaterialPropertyBlock();

				Vector4 offset = new Vector4(
					Random.Range(0.0f, 1.0f) > 0.5f ? 0 : 0.5f,
					Random.Range(0.0f, 1.0f) > 0.5f ? 0 : 0.5f,
					Random.Range(0.0f, 1.0f) > 0.5f ? 0 : 0.5f,
					Random.Range(0.0f, 1.0f) > 0.5f ? 0 : 0.5f
				);
				mpb.SetVector("_tileToKeep", offset);
				meshRenderer.SetPropertyBlock(mpb);
			}
		}
	}
}
