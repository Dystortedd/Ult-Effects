#version 150

#moj_import <fog.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;
uniform float GameTime;
uniform vec2 ScreenSize;

in float vertexDistance;
in vec4 vertexColor;
in vec2 texCoord0;

in vec3 glCornerTex1;
in vec3 glCornerTex2;
in vec3 glCornerTex3;
in vec3 glCornerTex4;

in vec3 uvCornerTex1;
in vec3 uvCornerTex2;
in vec3 uvCornerTex3;
in vec3 uvCornerTex4;

in vec4 sPos;
in float is3D;
in float fontID;
in float floatIsShadow;
in vec4 baseColor;
in float isMap;

out vec4 fragColor;

struct Text {
	float id;
	vec4 glPos;

	vec4 color;
	bool isShadow;

	vec2 uv;
	vec2 uvMin;
	vec2 uvMax;
	vec2 uvCenter;

	vec2 size;
	vec2 pos;
	vec2 localPos;
	vec2 charPos;
	ivec2 pixelPos;
};
Text text;

#moj_import <utils.glsl>
#moj_import <effects/text.glsl>
#moj_import <effects/font.glsl>

void main() {
	text.isShadow = floatIsShadow > 0.5;
	text.id = fontID;

	text.color = baseColor;
    vec4 color = texture(Sampler0, texCoord0) * vertexColor * ColorModulator;

	vec2 glCornerUV1 = glCornerTex1.xy / glCornerTex1.z;
	vec2 glCornerUV2 = glCornerTex2.xy / glCornerTex2.z;
	vec2 glCornerUV3 = glCornerTex3.xy / glCornerTex3.z;
	vec2 glCornerUV4 = glCornerTex4.xy / glCornerTex4.z;

	vec2 uvCornerUV1 = uvCornerTex1.xy / uvCornerTex1.z;
	vec2 uvCornerUV2 = uvCornerTex2.xy / uvCornerTex2.z;
	vec2 uvCornerUV3 = uvCornerTex3.xy / uvCornerTex3.z;
	vec2 uvCornerUV4 = uvCornerTex4.xy / uvCornerTex4.z;

	vec2 glMin = min(glCornerUV1,min(glCornerUV2,min(glCornerUV3,glCornerUV4)));
	vec2 glMax = max(glCornerUV1,max(glCornerUV2,max(glCornerUV3,glCornerUV4)));
	vec2 glSize = glMax - glMin;

	vec2 uvMin = min(uvCornerUV1,min(uvCornerUV2,min(uvCornerUV3,uvCornerUV4)));
	vec2 uvMax = max(uvCornerUV1,max(uvCornerUV2,max(uvCornerUV3,uvCornerUV4)));
	vec2 uvSize = uvMax - uvMin;

	text.uvMin = uvMin;
	text.uvMax = uvMax;
	text.uvCenter = uvMin + 0.25 * uvSize;

	text.localPos = ((sPos.xy - glMin) / glSize);
	text.localPos.y = 1.0 - text.localPos.y;

	text.pos = sPos.xy * 256.0;
	text.uv = texCoord0;

	text.charPos = 0.5 * (glMin + glMax) * uvSize * 256.0 / glSize;

	text.pixelPos = ivec2(int(floor((text.uv.yx + 0.00004 - text.uvMin.yx) * 256.0)));

	if(text.isShadow) text.charPos += vec2(-1.0, 1.0); text.pos += vec2(-1.0, 1.0);

#moj_import <configs/text.glsl>
#moj_import <configs/font.glsl>

	bool doTextureLookup = true;
	if(uvBoundsCheck(text.uv, uvMin, uvMax)) doTextureLookup = false;

	vec4 textureSample = texture(Sampler0, text.uv);

	if(isMap < 0.5) fragColor = text.color * textureSample;
    if(fragColor.a < (1 / 255.0)) discard;
    fragColor = linear_fog(fragColor, vertexDistance, FogStart, FogEnd, FogColor);
}