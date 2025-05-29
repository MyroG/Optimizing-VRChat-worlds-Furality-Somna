// Made with Amplify Shader Editor v1.9.8.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "MyroP/Somna/Egg"
{
	Properties
	{
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" "DisableBatching" = "True" }
		Cull Back
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#pragma target 3.0
		#define ASE_VERSION 19801
		#pragma surface surf StandardCustomLighting keepalpha addshadow fullforwardshadows nolightmap  nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		struct Input
		{
			float3 worldNormal;
			float2 uv_texcoord;
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};


		float3 RotateAroundAxis( float3 center, float3 original, float3 u, float angle )
		{
			original -= center;
			float C = cos( angle );
			float S = sin( angle );
			float t = 1 - C;
			float m00 = t * u.x * u.x + C;
			float m01 = t * u.x * u.y - S * u.z;
			float m02 = t * u.x * u.z + S * u.y;
			float m10 = t * u.x * u.y + S * u.z;
			float m11 = t * u.y * u.y + C;
			float m12 = t * u.y * u.z - S * u.x;
			float m20 = t * u.x * u.z - S * u.y;
			float m21 = t * u.y * u.z + S * u.x;
			float m22 = t * u.z * u.z + C;
			float3x3 finalMatrix = float3x3( m00, m01, m02, m10, m11, m12, m20, m21, m22 );
			return mul( finalMatrix, original ) + center;
		}


		float3 HSVToRGB( float3 c )
		{
			float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
			float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
			return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float4 transform194 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float2 temp_cast_0 = (( transform194.x + transform194.z )).xx;
			float dotResult4_g8 = dot( temp_cast_0 , float2( 12.9898,78.233 ) );
			float lerpResult10_g8 = lerp( 0.0 , 360.0 , frac( ( sin( dotResult4_g8 ) * 43758.55 ) ));
			float temp_output_190_0 = lerpResult10_g8;
			float3 ase_positionOS = v.vertex.xyz;
			float3 rotatedValue192 = RotateAroundAxis( float3( 0,0,0 ), ase_positionOS, float3( 0,1,0 ), temp_output_190_0 );
			v.vertex.xyz = rotatedValue192;
			v.vertex.w = 1;
			float3 ase_normalOS = v.normal.xyz;
			float3 rotatedValue196 = RotateAroundAxis( float3( 0,0,0 ), ase_normalOS, float3( 0,1,0 ), temp_output_190_0 );
			v.normal = rotatedValue196;
		}

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			SurfaceOutputStandard s198 = (SurfaceOutputStandard ) 0;
			float4 transform133 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float Seed185 = ( ( i.uv_texcoord.x + transform133.x + ( transform133.z * 1.12 ) ) * 31.0 );
			float3 hsvTorgb3_g7 = HSVToRGB( float3(Seed185,1.0,1.0) );
			float3 temp_output_164_0 = ( hsvTorgb3_g7 * frac( ( Seed185 * 0.3 ) ) );
			s198.Albedo = temp_output_164_0;
			float3 ase_normalWS = i.worldNormal;
			float3 ase_normalWSNorm = normalize( ase_normalWS );
			s198.Normal = ase_normalWSNorm;
			s198.Emission = ( temp_output_164_0 * float3( 0.2169811,0.2169811,0.2169811 ) );
			s198.Metallic = 0.0;
			s198.Smoothness = 0.51;
			s198.Occlusion = 1.0;

			data.light = gi.light;

			UnityGI gi198 = gi;
			#ifdef UNITY_PASS_FORWARDBASE
			Unity_GlossyEnvironmentData g198 = UnityGlossyEnvironmentSetup( s198.Smoothness, data.worldViewDir, s198.Normal, float3(0,0,0));
			gi198 = UnityGlobalIllumination( data, s198.Occlusion, s198.Normal, g198 );
			#endif

			float3 surfResult198 = LightingStandard ( s198, viewDir, gi198 ).rgb;
			surfResult198 += s198.Emission;

			#ifdef UNITY_PASS_FORWARDADD//198
			surfResult198 -= s198.Emission;
			#endif//198
			c.rgb = surfResult198;
			c.a = 1;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
}
/*ASEBEGIN
Version=19801
Node;AmplifyShaderEditor.CommentaryNode;188;-3312,-560;Inherit;False;978;374;;6;185;244;243;172;133;131;Seed generator, generated based on the position of the mesh and the tex coordiantes;1,1,1,1;0;0
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;133;-3264,-384;Inherit;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;131;-3264,-512;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;243;-3056,-320;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1.12;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;172;-2880,-496;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;244;-2752,-496;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;31;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;159;-2224,-128;Inherit;False;833;306;;3;187;166;245;Brightness value, also generated randomly : Color * [0.2 , 1.2];1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;185;-2592,-496;Inherit;False;Seed;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;160;-3328,-128;Inherit;False;938;294;;2;186;128;Color : We generate a kinda-random HUE value based on the mesh's world position and texture coordinates;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;187;-2208,48;Inherit;False;185;Seed;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;166;-2000,32;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.3;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;186;-3104,-64;Inherit;False;185;Seed;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;128;-2736,-80;Inherit;True;Simple HUE;-1;;7;32abb5f0db087604486c2db83a2e817a;0;1;1;FLOAT;0;False;4;FLOAT3;6;FLOAT;7;FLOAT;5;FLOAT;8
Node;AmplifyShaderEditor.FractNode;245;-1824,32;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;194;-1072,400;Inherit;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;164;-1376,32;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;195;-880,432;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;130;-880,224;Inherit;False;Constant;_Float0;Float 0;7;0;Create;True;0;0;0;False;0;False;0.51;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;242;-1072,128;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0.2169811,0.2169811,0.2169811;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;190;-704,416;Inherit;False;Random Range;-1;;8;7b754edb8aebbfb4a9ace907af661cfc;0;3;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT;360;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;193;-656,544;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalVertexDataNode;197;-656,688;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CustomStandardSurface;198;-656,48;Inherit;False;Metallic;Tangent;6;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,1;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RotateAboutAxisNode;192;-336,400;Inherit;False;False;4;0;FLOAT3;0,1,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RotateAboutAxisNode;196;-336,560;Inherit;False;False;4;0;FLOAT3;0,1,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;122;48,-192;Float;False;True;-1;2;AmplifyShaderEditor.MaterialInspector;0;0;CustomLighting;MyroP/Somna/Egg;False;False;False;False;False;False;True;False;True;True;True;True;False;True;False;False;False;False;False;False;True;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Geometry;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Absolute;0;;0;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;243;0;133;3
WireConnection;172;0;131;1
WireConnection;172;1;133;1
WireConnection;172;2;243;0
WireConnection;244;0;172;0
WireConnection;185;0;244;0
WireConnection;166;0;187;0
WireConnection;128;1;186;0
WireConnection;245;0;166;0
WireConnection;164;0;128;6
WireConnection;164;1;245;0
WireConnection;195;0;194;1
WireConnection;195;1;194;3
WireConnection;242;0;164;0
WireConnection;190;1;195;0
WireConnection;198;0;164;0
WireConnection;198;2;242;0
WireConnection;198;4;130;0
WireConnection;192;1;190;0
WireConnection;192;3;193;0
WireConnection;196;1;190;0
WireConnection;196;3;197;0
WireConnection;122;13;198;0
WireConnection;122;11;192;0
WireConnection;122;12;196;0
ASEEND*/
//CHKSM=F55C00CAD73D83E91C865B84FE61B484469D0928