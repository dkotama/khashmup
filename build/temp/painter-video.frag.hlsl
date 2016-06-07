float mod(float x, float y) {
	return x - y * floor(x / y);
}


static float4 f_color;
static float4 f_gl_FragColor;
uniform sampler2D tex;
static float2 f_texCoord;

struct InputFrag {
	float4 color : TEXCOORD0;
	float2 texCoord : TEXCOORD1;
};

struct OutputFrag {
	float4 gl_FragColor : COLOR;
};

void frag_main();

OutputFrag main(InputFrag input)
{
	f_color = input.color;
	f_texCoord = input.texCoord;
	frag_main();
	OutputFrag output;
	output.gl_FragColor = f_gl_FragColor;
	return output;
}


void frag_main()
{
	float4 texcolor;
	texcolor = (tex2D(tex, f_texCoord) * f_color);
	texcolor = float4((float3(texcolor[0], texcolor[1], texcolor[2]) * f_color[3])[0], (float3(texcolor[0], texcolor[1], texcolor[2]) * f_color[3])[1], (float3(texcolor[0], texcolor[1], texcolor[2]) * f_color[3])[2], texcolor[3]);
	f_gl_FragColor = texcolor;
	return;
}

