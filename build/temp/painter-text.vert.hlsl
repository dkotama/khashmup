float mod(float x, float y) {
	return x - y * floor(x / y);
}

uniform float4 dx_ViewAdjust;
static float4 v_fragmentColor;
static float4 v_gl_Position;
uniform float4x4 projectionMatrix;
static float2 v_texCoord;
static float2 v_texPosition;
static float4 v_vertexColor;
static float3 v_vertexPosition;

struct InputVert {
	float2 texPosition : TEXCOORD0;
	float4 vertexColor : TEXCOORD1;
	float3 vertexPosition : TEXCOORD2;
};

struct OutputVert {
	float4 gl_Position : POSITION;
	float4 fragmentColor : TEXCOORD0;
	float2 texCoord : TEXCOORD1;
};

void vert_main();

OutputVert main(InputVert input)
{
	v_texPosition = input.texPosition;
	v_vertexColor = input.vertexColor;
	v_vertexPosition = input.vertexPosition;
	vert_main();
	OutputVert output;
	output.fragmentColor = v_fragmentColor;
	output.gl_Position = v_gl_Position;
	output.texCoord = v_texCoord;
	output.gl_Position.x = output.gl_Position.x - dx_ViewAdjust.x * output.gl_Position.w;
	output.gl_Position.y = output.gl_Position.y + dx_ViewAdjust.y * output.gl_Position.w;
	output.gl_Position.z = (output.gl_Position.z + output.gl_Position.w) * 0.5;
	return output;
}


void vert_main()
{
	v_gl_Position = mul(transpose(projectionMatrix), float4(v_vertexPosition[0], v_vertexPosition[1], v_vertexPosition[2], 1.0));
	v_texCoord = v_texPosition;
	v_fragmentColor = v_vertexColor;
	return;
}

