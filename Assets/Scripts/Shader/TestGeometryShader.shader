// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Unlit/TestGeometryShader"
{
    Properties
    {
        _Color ("Color", Color) = (.2,0.2,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
      
   

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertexModelSpace : POSITION;
                float3 normals : NORMAL;
            };

            struct v2f
            {
                float4 vertexClipPos : SV_POSITION;
                float4 tint : COLOR;
   
            };
            
            /*struct g2f
            {
                float4 vertexClipPosAltered : SV_POSITION; 
            };*/


            v2f vert (appdata i)
            {
                v2f o;
                o.vertexClipPos = UnityObjectToClipPos(i.vertexModelSpace);
                float4 vertexWorldPos = mul(unity_ObjectToWorld, i.vertexModelSpace);
                float3 toCamDir = normalize(_WorldSpaceCameraPos - vertexWorldPos.xyz);
                
                o.tint = float4(1,1,1,1);
               o.tint.xyz = toCamDir.xyz;
                o.tint = abs(o.tint);
                o.tint.w = 1;
                return o;
            }
            /*[maxvertexcount(3)]
            v2g geo (v2g i, inout TriangleStream<geometryOutput> triStream)
            {
                float4 alterPos = float4(0.1,0,0,0);
                i.vertexClipPos += alterPos;
                g2f o;
                o.vertexClipPosAltered = i.vertexClipPos;
                return o;
            }*/
            
            
            float4 _Color;
            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = _Color;
                col *= i.tint;
                return col;
            }
            ENDCG
        }
    }
}
