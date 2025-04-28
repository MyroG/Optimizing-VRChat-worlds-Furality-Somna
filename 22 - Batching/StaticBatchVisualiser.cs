using UnityEditor;
using UnityEngine;

public class StaticBatchVisualiser : MonoBehaviour
{
	void Start()
	{
		var staticObjects = FindObjectsOfType<MeshRenderer>();

		foreach (var renderer in staticObjects)
		{
			if (!renderer.gameObject.isStatic)
				continue;

			var filter = renderer.GetComponent<MeshFilter>();
			if (filter == null || filter.sharedMesh == null)
				continue;

			Random.InitState(filter.mesh.name.GetHashCode());

			Vector3 seed = new Vector3(
				Random.Range(0.0f, 1.0f),
				Random.Range(0.0f, 1.0f),
				Random.Range(0.0f, 1.0f)
			);
			renderer.material.SetVector("_Seed", seed);
		}
	}
}