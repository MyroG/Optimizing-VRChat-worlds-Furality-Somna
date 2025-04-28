using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DrawInstanced : MonoBehaviour
{
	public Mesh MeshToRender;
	public Material MaterialToApply;
	public int AreaSize;

	private List<Matrix4x4> _matrices = new List<Matrix4x4>();
	private const int INSTANCE_LIMIT = 1022;

	void Start() {
		// We are setting here a list of positions, rotations and scales (as TRS matrices) where we
		// want to render our GPU Instanced meshes
 		for (int x = 0; x < AreaSize; x++) {
			for (int z = 0; z < AreaSize; z++) {
				Matrix4x4 matrix = Matrix4x4.TRS(
					new Vector3(x * 0.7f, 0, z * 0.7f), //Position
					Quaternion.identity, //Rotation
					Vector3.one //Scale
				);
				_matrices.Add(matrix);
			}
		}
	}

	void Update() {
		// Rendering our meshes
		for (int i = 0; i < _matrices.Count; i += INSTANCE_LIMIT) {
			int count = Mathf.Min(INSTANCE_LIMIT, _matrices.Count - i);
			Graphics.DrawMeshInstanced(MeshToRender, 0, MaterialToApply, _matrices.GetRange(i, count));
		}
	}
}

