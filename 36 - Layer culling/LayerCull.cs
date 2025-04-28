using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LayerCull : MonoBehaviour
{
	public Camera CameraInstance;
	public float WaterCullingDistance = 15;
	public float UICullingDistance = 2;
	void Start()
    {

	}

	private void Update()
	{
		float[] distances = new float[32];
		distances[4] = WaterCullingDistance;
		distances[5] = UICullingDistance;
		CameraInstance.layerCullDistances = distances;

		//On VRChat
		//VRCCameraSettings.ScreenCamera.layerCullDistances = distances;
	}
}
