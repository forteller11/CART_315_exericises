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
            #pragma geometry geom
               #pragma target 4.0
   

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertexModel : POSITION;
                float3 normals : NORMAL;
            };

            struct v2g
            {
                float4 vertexWorld: POSITION1;
                float4 vertexClip: POSITION2;
                float4 camToVert: POSITION3; //where xyz is delta, and w is scalar
                float4 tint : COLOR;
            };
            
            struct g2f
            {
                float4 vertexAltered : POSITION; 
                float4 tint: COLOR;
            };


            v2g vert (appdata i)
            {
                v2g o;
                //o.vertexClipPos = UnityObjectToClipPos(i.vertexModelSpace);
                o.vertexClip = UnityObjectToClipPos(i.vertexModel);
                float4 vertexWorldPos = mul(unity_ObjectToWorld, i.vertexModel);
                o.vertexWorld = vertexWorldPos;
                float3 toCam = _WorldSpaceCameraPos - vertexWorldPos.xyz;
                float toCamDist = length(toCam);
                float3 toCamDir = normalize(toCam);
                
                o.camToVert.xyz = toCamDir;
                o.camToVert.w = toCamDist;
                o.tint = float4(1,1,1,1);
                o.tint.xyz = toCamDir.xyz;
                o.tint = abs(o.tint);
                o.tint.w = 1;
                return o;
            }
            
            //don't return stuff?
            //return triangleStream?
            [maxvertexcount(3)]
            void geom (
                triangle v2g IN[3],
                inout TriangleStream<g2f> triStream)
            {
            
            for (int i = 0; i < 3; i ++)
            {
                g2f v;
                float4 pushedAway = IN[i].vertexWorld *2;
                v.vertexAltered = UnityObjectToClipPos(pushedAway);
                v.tint = IN[i].tint;
                triStream.Append(v);
            }
     
            }
            
            
            float4 _Color;
            fixed4 frag (g2f i) : SV_Target
            {
                fixed4 col = _Color;
                col *= i.tint;
                return col;
            }
            ENDCG
        }
    }
}
