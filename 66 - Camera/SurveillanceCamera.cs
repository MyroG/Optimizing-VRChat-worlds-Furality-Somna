using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SurveillanceCamera : MonoBehaviour
{
	/// Can be used on the screen of a surveillance camera. the script 
	/// disables the camera when the player isn't directly looking at a screen.
	/// Attach this script on a screen.
	/// Outside of VRChat, use OnBecameVisible and OnBecameInvisible instead
	public Camera CameraInstance;

	private void Start()
	{
		CameraInstance.gameObject.SetActive(false);
	}

	public void OnBecameVisible() //Use _onBecameVisible inside VRChat
	{
		CameraInstance.gameObject.SetActive(true);
	}

	public void OnBecameInvisible() //Use _onBecameInvisible inside VRChat
	{
		CameraInstance.gameObject.SetActive(false);
	}
}
