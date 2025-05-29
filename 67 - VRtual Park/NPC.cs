using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NPC : MonoBehaviour
{
	public float Velocity = 1.0f;
	public Transform[] Destinations;

	Rigidbody _npcRigidBody;
	private int _indexDestination;
	void Start()
    {
		_npcRigidBody = GetComponent<Rigidbody>();
		NPCMovementSystem();
	}

	public void NPCMovementSystem()
	{
		// Finding the next intersection
		Vector3 destinationToReach = FindNextDestination();
		Vector3 currentNPCPosition = _npcRigidBody.transform.position;

		//Direction the NPC needs to be pushed
		Vector3 direction = destinationToReach - currentNPCPosition;
		float distanceToDestination = direction.magnitude;

		//And we push the NPC
		_npcRigidBody.velocity = direction.normalized * Velocity;

		//Destination will be reached in "time" seconds
		//then we push the NPC again
		float time = distanceToDestination / Velocity;
		Invoke(
			nameof(NPCMovementSystem), time
		);
	}

	private Vector3 FindNextDestination()
	{
		_indexDestination++;
		if (_indexDestination >= Destinations.Length)
		{
			_indexDestination = 0;
		}
		return Destinations[_indexDestination].position;
	}
}
