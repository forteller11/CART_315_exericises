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
                float4 vertexClip: POSITION;
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
                float3 toCamDir = normalize(_WorldSpaceCameraPos - vertexWorldPos.xyz);
                
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
            g2f v1;
            v1.vertexAltered = IN[0].vertexClip + float4(0,0,0,-.5);
            v1.tint = IN[0].tint;
            triStream.Append(v1);
            
            g2f v2;
            v2.vertexAltered = IN[1].vertexClip;
            v2.tint = IN[1].tint;
            triStream.Append(v2);
            
            g2f v3;
            v3.vertexAltered = IN[2].vertexClip;
            v3.tint = IN[2].tint;
            triStream.Append(v3);
     
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
