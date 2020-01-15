using System;
using UnityEngine;

public class WarpMesh : MonoBehaviour
{
    private MeshFilter _meshFilter;
    private Mesh _mesh;
    private float [] _oscillationSpeed;
    private float [] _oscillationIndex;
    public float MaxOscillationSpeed = Mathf.PI / 8;
    public float MinValue = 1f;
    public float MaxValue = 2f;
    private Vector3[] _baseMesh;

    void Start()
    {
        _meshFilter = GetComponent<MeshFilter>();
        _mesh = _meshFilter.mesh;
        _oscillationSpeed = new float[_mesh.vertices.Length];
        _oscillationIndex = new float[_mesh.vertices.Length];
        _baseMesh = _mesh.vertices;
        
        for (int i = 0; i < _oscillationSpeed.Length; i++)
        {
            float normalizeIndex = (float) i / _oscillationSpeed.Length;
            _oscillationSpeed[i] = Mathf.Lerp(0, MaxOscillationSpeed, normalizeIndex);
            Debug.Log(_oscillationSpeed[i]);
        }
    }

    void Update()
    {
        Vector3[] inputVerts = Clone(_baseMesh);
        for (int i = 0; i < inputVerts.Length; i++)
        {
            _oscillationIndex[i] += _oscillationSpeed[i];
            float normValue = (Mathf.Cos(_oscillationIndex[i]) + 2) / 2f;
            float scaledValue = Mathf.Lerp(MinValue, MaxValue, normValue); 
            inputVerts[i] = inputVerts[i] * scaledValue;
        }
        Debug.Log("baseMesh  "+_baseMesh[0]);

        _mesh.vertices = inputVerts;
        _mesh.RecalculateBounds();
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
