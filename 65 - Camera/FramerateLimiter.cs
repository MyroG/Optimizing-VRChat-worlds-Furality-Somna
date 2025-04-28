using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FramerateLimiter : MonoBehaviour
{
	/// Renders a camera view at a given framerate
	public Camera CameraInstance;
	public float Framerate;

	void Start()
	{
		CameraInstance.enabled = false;
		CustomLoop();
	}

	private void CustomLoop()
	{
		if (CameraInstance.gameObject.activeSelf)
		{
			CameraInstance.Render();
		}
		Invoke(
			nameof(CustomLoop), 1.0f / Framerate
		); // Use "SendCustomEventDelayedSeconds" inside of VRC
	}
}

