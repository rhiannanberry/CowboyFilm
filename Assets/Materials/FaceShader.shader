Shader "Unlit/FaceShader"
{
    Properties
    {
        _FaceColor("Face Color", Color) = (1,1,1,1)
        _MainTex ("Texture", 2D) = "white" {}
        _FaceScale("Face Scale", Float) = 1
        _FaceV("Vertical Face Offset", Range(-.5,.5)) = 0
        _FaceH("Horizontal Face Offset", Range(-.5,.5)) = 0
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
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float4 _FaceColor;
            float _FaceScale;
            float _FaceH;
            float _FaceV;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                float scale = 1.0/_FaceScale;
                v.uv.x = v.uv.x*scale;
                v.uv.y = v.uv.y*scale;
                v.uv.x -= ((scale-1)/2.0 + _FaceH);
                v.uv.y -= ((scale-1)/2.0 + _FaceV);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                if (col.a < .5) {
                    col = _FaceColor;
                }
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    }
}
