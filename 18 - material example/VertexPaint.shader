// Made with Amplify Shader Editor v1.9.8.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "MyroP/Somna/VertexBlending"
{
	Properties
	{
		_RedchannelAlbedo("Red channel - Albedo", 2D) = "white" {}
		_RedchannelNormal("Red channel - Normal", 2D) = "bump" {}
		_RedchannelRoughness("Red channel - Roughness", 2D) = "bump" {}
		_GreenchannelAlbedo("Green channel - Albedo", 2D) = "white" {}
		_GreenchannelNormal("Green channel - Normal", 2D) = "bump" {}
		_GreenchannelRoughness("Green channel - Roughness", 2D) = "bump" {}
		_BluechannelAlbedo("Blue channel - Albedo", 2D) = "white" {}
		_BluechannelNormal("Blue channel - Normal", 2D) = "bump" {}
		_BluechannelRoughness("Blue channel - Roughness", 2D) = "bump" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.5
		#define ASE_VERSION 19801
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _RedchannelNormal;
		uniform float4 _RedchannelNormal_ST;
		uniform sampler2D _GreenchannelNormal;
		uniform float4 _GreenchannelNormal_ST;
		uniform sampler2D _BluechannelNormal;
		uniform float4 _BluechannelNormal_ST;
		uniform sampler2D _RedchannelAlbedo;
		uniform float4 _RedchannelAlbedo_ST;
		uniform sampler2D _GreenchannelAlbedo;
		uniform float4 _GreenchannelAlbedo_ST;
		uniform sampler2D _BluechannelAlbedo;
		uniform float4 _BluechannelAlbedo_ST;
		uniform sampler2D _RedchannelRoughness;
		uniform float4 _RedchannelRoughness_ST;
		uniform sampler2D _GreenchannelRoughness;
		uniform float4 _GreenchannelRoughness_ST;
		uniform sampler2D _BluechannelRoughness;
		uniform float4 _BluechannelRoughness_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_RedchannelNormal = i.uv_texcoord * _RedchannelNormal_ST.xy + _RedchannelNormal_ST.zw;
			float2 uv_GreenchannelNormal = i.uv_texcoord * _GreenchannelNormal_ST.xy + _GreenchannelNormal_ST.zw;
			float2 uv_BluechannelNormal = i.uv_texcoord * _BluechannelNormal_ST.xy + _BluechannelNormal_ST.zw;
			o.Normal = ( ( ( UnpackNormal( tex2D( _RedchannelNormal, uv_RedchannelNormal ) ) * i.vertexColor.r ) + ( i.vertexColor.g * UnpackNormal( tex2D( _GreenchannelNormal, uv_GreenchannelNormal ) ) ) + ( i.vertexColor.b * UnpackNormal( tex2D( _BluechannelNormal, uv_BluechannelNormal ) ) ) ) / ( i.vertexColor.r + i.vertexColor.g + i.vertexColor.b ) );
			float2 uv_RedchannelAlbedo = i.uv_texcoord * _RedchannelAlbedo_ST.xy + _RedchannelAlbedo_ST.zw;
			float2 uv_GreenchannelAlbedo = i.uv_texcoord * _GreenchannelAlbedo_ST.xy + _GreenchannelAlbedo_ST.zw;
			float2 uv_BluechannelAlbedo = i.uv_texcoord * _BluechannelAlbedo_ST.xy + _BluechannelAlbedo_ST.zw;
			o.Albedo = ( ( ( tex2D( _RedchannelAlbedo, uv_RedchannelAlbedo ).rgb * i.vertexColor.r ) + ( i.vertexColor.g * tex2D( _GreenchannelAlbedo, uv_GreenchannelAlbedo ).rgb ) + ( i.vertexColor.b * tex2D( _BluechannelAlbedo, uv_BluechannelAlbedo ).rgb ) ) / ( i.vertexColor.r + i.vertexColor.g + i.vertexColor.b ) );
			float2 uv_RedchannelRoughness = i.uv_texcoord * _RedchannelRoughness_ST.xy + _RedchannelRoughness_ST.zw;
			float2 uv_GreenchannelRoughness = i.uv_texcoord * _GreenchannelRoughness_ST.xy + _GreenchannelRoughness_ST.zw;
			float2 uv_BluechannelRoughness = i.uv_texcoord * _BluechannelRoughness_ST.xy + _BluechannelRoughness_ST.zw;
			o.Smoothness = ( 1.0 - ( ( ( tex2D( _RedchannelRoughness, uv_RedchannelRoughness ).rgb * i.vertexColor.r ) + ( i.vertexColor.g * tex2D( _GreenchannelRoughness, uv_GreenchannelRoughness ).rgb ) + ( i.vertexColor.b * tex2D( _BluechannelRoughness, uv_BluechannelRoughness ).rgb ) ) / ( i.vertexColor.r + i.vertexColor.g + i.vertexColor.b ) ) ).x;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
}
/*ASEBEGIN
Version=19801
Node;AmplifyShaderEditor.SamplerNode;20;-912,1040;Inherit;True;Property;_RedchannelRoughness;Red channel - Roughness;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;bump;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode;18;-912,1232;Inherit;True;Property;_GreenchannelRoughness;Green channel - Roughness;5;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;bump;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode;19;-912,1424;Inherit;True;Property;_BluechannelRoughness;Blue channel - Roughness;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;bump;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode;3;-896,48;Inherit;True;Property;_BluechannelAlbedo;Blue channel - Albedo;6;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode;2;-896,-144;Inherit;True;Property;_GreenchannelAlbedo;Green channel - Albedo;3;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.FunctionNode;21;-470.604,1358.213;Inherit;False;Vertex Blending;-1;;5;065e354603f0c9e48ba880b0fe8e6dae;0;3;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;15;-912,320;Inherit;True;Property;_RedchannelNormal;Red channel - Normal;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode;14;-912,512;Inherit;True;Property;_GreenchannelNormal;Green channel - Normal;4;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode;13;-912,704;Inherit;True;Property;_BluechannelNormal;Blue channel - Normal;7;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode;1;-896,-336;Inherit;True;Property;_RedchannelAlbedo;Red channel - Albedo;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.FunctionNode;16;-496,496;Inherit;False;Vertex Blending;-1;;3;065e354603f0c9e48ba880b0fe8e6dae;0;3;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;22;-238.7626,1389.769;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;17;-480,-32;Inherit;False;Vertex Blending;-1;;4;065e354603f0c9e48ba880b0fe8e6dae;0;3;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;0;Standard;MyroP/Somna/VertexBlending;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;21;1;20;5
WireConnection;21;2;18;5
WireConnection;21;3;19;5
WireConnection;16;1;15;0
WireConnection;16;2;14;0
WireConnection;16;3;13;0
WireConnection;22;0;21;0
WireConnection;17;1;1;5
WireConnection;17;2;2;5
WireConnection;17;3;3;5
WireConnection;0;0;17;0
WireConnection;0;1;16;0
WireConnection;0;4;22;0
ASEEND*/
//CHKSM=DB147295F14D5F873DD56BC0E64C0F45603AAC1D