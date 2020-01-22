using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(MeshFilter))]
public class MeshManipulatorManager : MonoBehaviour
{
    [SerializeField]
    public List<IMeshManipulator> MeshManipulatorScripts = new List<IMeshManipulator>();
    private Vector3[] _baseVerts;
    private MeshFilter _meshFilter;
    private Mesh _mesh;

    void Start()
    {
        _meshFilter = GetComponent<MeshFilter>();
        _mesh = GetComponent<Mesh>();
        //GetComponenet<
    }
    void Update()
    {
        Vector3[] transformedVerts = Clone(_baseVerts);
        foreach (var script in MeshManipulatorScripts)
        {
            script.ManipulateMesh(_baseVerts);
        }
    }
    
    Vector3[] Clone(Vector3[] src)
    {
        Vector3 [] newVec = new Vector3 [src.Length];
        for (int i = 0; i < src.Length; i++)
        {
            newVec[i] = src[i];
        }

        return newVec;
    }
}



public interface IMeshManipulator
{
    Vector3[] ManipulateMesh(Vector3[] verts);
}
