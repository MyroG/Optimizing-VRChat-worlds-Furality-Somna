// Upgrade NOTE: upgraded instancing buffer 'MyroPSomnaGPUInstancingUVTile' to new syntax.

// Made with Amplify Shader Editor v1.9.8.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "MyroP/Somna/GPUInstancingUVTile"
{
	Properties
	{
		_tileToKeep("tileToKeep", Vector) = (0,0,0,0)
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.5
		#pragma multi_compile_instancing
		#define ASE_VERSION 19801
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			half filler;
		};

		UNITY_INSTANCING_BUFFER_START(MyroPSomnaGPUInstancingUVTile)
			UNITY_DEFINE_INSTANCED_PROP(float2, _tileToKeep)
#define _tileToKeep_arr MyroPSomnaGPUInstancingUVTile
		UNITY_INSTANCING_BUFFER_END(MyroPSomnaGPUInstancingUVTile)


		float KeepVertice6( float2 currentUvCoord, float2 tileToKeep )
		{
			 return tileToKeep.x < currentUvCoord.x
			&& tileToKeep.y < currentUvCoord.y
			&& tileToKeep.x + 0.5f > currentUvCoord.x
			&& tileToKeep.y + 0.5f > currentUvCoord.y;
		}


		float3 NaN3(  )
		{
			 return float3(0.0f/0.0f, 0.0f/0.0f, 0.0f/0.0f);
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 currentUvCoord6 = v.texcoord.xy;
			float2 _tileToKeep_Instance = UNITY_ACCESS_INSTANCED_PROP(_tileToKeep_arr, _tileToKeep);
			float2 tileToKeep6 = _tileToKeep_Instance;
			float localKeepVertice6 = KeepVertice6( currentUvCoord6 , tileToKeep6 );
			float3 localNaN3 = NaN3();
			float3 ifLocalVar5 = 0;
			if( localKeepVertice6 < 0.5 )
				ifLocalVar5 = localNaN3;
			v.vertex.xyz += ifLocalVar5;
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 color4 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
			o.Albedo = color4.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
}
/*ASEBEGIN
Version=19801
Node;AmplifyShaderEditor.TexCoordVertexDataNode;2;-1184,96;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;7;-1120,240;Inherit;False;InstancedProperty;_tileToKeep;tileToKeep;0;0;Create;True;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.CustomExpressionNode;6;-768,144;Inherit;False; return tileToKeep.x < currentUvCoord.x$&& tileToKeep.y < currentUvCoord.y$&& tileToKeep.x + 0.5f > currentUvCoord.x$&& tileToKeep.y + 0.5f > currentUvCoord.y@;1;Create;2;True;currentUvCoord;FLOAT2;0,0;In;;Inherit;False;True;tileToKeep;FLOAT2;0,0;In;;Inherit;False;KeepVertice;True;False;0;;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;3;-672,544;Inherit;False; return float3(0.0f/0.0f, 0.0f/0.0f, 0.0f/0.0f)@;3;Create;0;NaN;True;False;0;;False;0;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;4;-400,-48;Inherit;False;Constant;_Color0;Color 0;1;0;Create;True;0;0;0;False;0;False;1,1,1,0;0,0,0,0;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.ConditionalIfNode;5;-416,304;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;0;Standard;MyroP/Somna/GPUInstancingUVTile;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;6;0;2;0
WireConnection;6;1;7;0
WireConnection;5;0;6;0
WireConnection;5;4;3;0
WireConnection;0;0;4;5
WireConnection;0;11;5;0
ASEEND*/
//CHKSM=3CB7462788D8C1AF9797981F8D36B77AC5D8A3F8