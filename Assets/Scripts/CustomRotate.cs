using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CustomRotate : MonoBehaviour
{
   public Vector3 Axis = Vector3.one;
   public float RotateSpeed = 0.02f;
   void FixedUpdate()
   {
      if (Input.GetButton("Fire1"))
      {
         Debug.Log("rotate");
         transform.Rotate(Axis, RotateSpeed);
      }
       
   }
    
}
