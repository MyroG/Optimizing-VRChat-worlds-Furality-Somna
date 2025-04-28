using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.Threading;
using TMPro;
using UnityEngine;

public class fps : MonoBehaviour
{
	public TextMeshProUGUI FPSCounter;
	public string Prefix;
	private double _startTime;
	private long _fps;

	internal double GetFPS()
	{
		return _fps / _startTime;
	}

	internal void Restart()
	{
		_startTime = 0;
		_fps = 0;
	}

	void Start()
    {
		_startTime = 0;
		Thread.CurrentThread.CurrentCulture = CultureInfo.GetCultureInfo("en-US");
	}

    void Update()
    {
		_startTime += Time.deltaTime;
		_fps++;

		double fps = _fps / _startTime;

        if (Prefix != "")
        {
			FPSCounter.text = $"{Prefix} : {fps.ToString("0.000")}  FPS";
		}
		else
		{
			FPSCounter.text = $"{fps.ToString("0.000")}  FPS";
		}
	}
}
