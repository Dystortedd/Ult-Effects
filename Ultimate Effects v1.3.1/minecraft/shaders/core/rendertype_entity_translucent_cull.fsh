#version 150

#moj_import <fog.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;
uniform float GameTime;

in float vertexDistance;
in vec4 vertexColor;
in vec2 texCoord0;
in vec2 texCoord1;

in vec4 baseColor;
in vec4 lightColor;

out vec4 fragColor;

struct Leather {
	vec4 color;
	vec2 uv;
	float emissive;
	float applyColor;
};
Leather leather;

#moj_import <utils.glsl>
#moj_import <effects/leather.glsl>

void main() {
	leather.color = texture(Sampler0, texCoord0);
	leather.uv = texCoord0;
	leather.emissive = 0.0;
	leather.applyColor = 1.0;

	#moj_import <configs/leather.glsl>

    vec4 color = leather.color * mix(vec4(1.0), baseColor, leather.applyColor) * mix(lightColor * vertexColor, vec4(1.0), leather.emissive) * ColorModulator;

    if (color.a < 0.1) {discard;}

    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}