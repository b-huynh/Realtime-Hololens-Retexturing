struct PixelShaderInput
{
	float4 Position : SV_POSITION;
	float4 Normal : NORMAL;
	float3 WorldPosition : POSITION;
	// float2 UV : TEXCOORD;
};

/*
Texture2D<uint> LuminanceTexture : register(t0);
Texture2D<uint2> ChrominanceTexture : register(t1);
*/

TextureCube CubeMap : register(t0);

SamplerState CubeSamplerState
{
	Filter = ANISOTROPIC;
};

/*
float4 YuvToRgb(float2 textureUV)
{
	int3 location = int3(0, 0, 0);
	location.x = (int)(1408 * (textureUV.x));
	location.y = (int)(792 * (1.0f - textureUV.y));
	uint y = LuminanceTexture.Load(location).x;
	uint2 uv = ChrominanceTexture.Load(location / 2).xy;
	int c = y - 16;
	int d = uv.x - 128;
	int e = uv.y - 128;
	int r = (298 * c + 409 * e + 128) >> 8;
	int g = (298 * c - 100 * d - 208 * e + 128) >> 8;
	int b = (298 * c + 516 * d + 128) >> 8;
	float4 rgb = float4(0.0f, 0.0f, 0.0f, 255.0f);
	rgb.x = max(0, min(255, r));
	rgb.y = max(0, min(255, g));
	rgb.z = max(0, min(255, b));
	return rgb / 255.0;
}
*/

float4 main(PixelShaderInput input) : SV_TARGET
{
	return CubeMap.Sample(CubeSamplerState, input.WorldPosition);
}