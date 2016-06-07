float mod(float x, float y) {
	return x - y * floor(x / y);
}


static float4 f_fragmentColor;
static float4 f_gl_FragColor;

struct InputFrag {
	float4 fragmentColor : TEXCOORD0;
};

struct OutputFrag {
	float4 gl_FragColor : COLOR;
};

void frag_main();

OutputFrag main(InputFrag input)
{
	f_fragmentColor = input.fragmentColor;
	frag_main();
	OutputFrag output;
	output.gl_FragColor = f_gl_FragColor;
	return output;
}


void frag_main()
{
	f_gl_FragColor = f_fragmentColor;
	return;
}

