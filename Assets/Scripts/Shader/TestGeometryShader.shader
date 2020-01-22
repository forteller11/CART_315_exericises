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
            #pragma geometry geo
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertexModelSpace : POSITION;
     
            };

            struct v2g
            {
                float4 vertexClipPos : SV_POSITION;
            };
            
            struct g2f
            {
                float4 vertexClipPosAltered : SV_POSITION;
            };


            v2g vert (appdata v)
            {
                v2g o;
                o.vertexClipPos = UnityObjectToClipPos(v.vertexModelSpace);
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
                return col;
            }
            ENDCG
        }
    }
}
