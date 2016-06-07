float mod(float x, float y) {
	return x - y * floor(x / y);
}


static float4 f_fragmentColor;
static float4 f_gl_FragColor;
uniform sampler2D tex;
static float2 f_texCoord;

struct InputFrag {
	float4 fragmentColor : TEXCOORD0;
	float2 texCoord : TEXCOORD1;
};

struct OutputFrag {
	float4 gl_FragColor : COLOR;
};

void frag_main();

OutputFrag main(InputFrag input)
{
	f_fragmentColor = input.fragmentColor;
	f_texCoord = input.texCoord;
	frag_main();
	OutputFrag output;
	output.gl_FragColor = f_gl_FragColor;
	return output;
}


void frag_main()
{
	f_gl_FragColor = float4(float3(f_fragmentColor[0], f_fragmentColor[1], f_fragmentColor[2])[0], float3(f_fragmentColor[0], f_fragmentColor[1], f_fragmentColor[2])[1], float3(f_fragmentColor[0], f_fragmentColor[1], f_fragmentColor[2])[2], (tex2D(tex, f_texCoord)[0] * f_fragmentColor[3]));
	return;
}

