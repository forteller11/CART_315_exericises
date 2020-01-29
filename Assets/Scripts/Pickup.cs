using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UIElements;

public class Pickup : MonoBehaviour
{
    void Update()
    {

    }

    private void OnMouseDown()
    {
        //this is where the destroy script was created in class
        
        var warp = gameObject.GetComponent<WarpMesh>();
        if (warp == null)
        {
             warp = gameObject.AddComponent<WarpMesh>();
             warp.MaxValue = 1;
             warp.MinValue = 1;
        }

        warp.MinValue -= 0.2f;
        warp.MaxValue += 0.2f;
    }
}
