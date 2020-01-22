using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Bounce : MonoBehaviour
{
    public Vector3 ApplyForce = new Vector3(0, 1000, 0);
    

    private void OnTriggerStay(Collider other)
    {
        Rigidbody rb = other.GetComponent<Rigidbody>();
        if (rb != null)
        {
            Debug.Log("RB");
            rb.AddForce(ApplyForce * Time.deltaTime);
        }
            
        
        //other.transform.Translate(ApplyForce);
        
    }
}
