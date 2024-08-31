#version 150

#moj_import <fog.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;
in vec3 Normal;

uniform sampler2D Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform int FogShape;
uniform float GameTime;
uniform vec2 ScreenSize;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;

struct Text {
	vec4 color;
    bool isShadow;
	float id;
	vec4 glPos;
};
Text text;

#moj_import <utils.glsl>
#moj_import <effect/text_shaders.glsl>
#moj_import <effect/font_shaders.glsl>

void main() {

	vec4 pos = vec4(Position, 1.0);

	text.color = Color;
    vertexDistance = length((ModelViewMat * vec4(Position, 1.0)).xyz);
    vertexColor = text.color * texelFetch(Sampler2, UV2 / 16, 0);
    texCoord0 = UV0;

	text.id = floor((pos.y + 1000.0) / 5000.0);
	pos.y = mod(pos.y + 1000.0, 5000.0) - 1000.0;
	gl_Position = ProjMat * ModelViewMat * pos;

	text.glPos = gl_Position;
	if (ProjMat[3][3] == 0.0) {
		text.glPos *= 0.25;
	}

	#moj_import <config/font_shaders_config.glsl>
	#moj_import <config/text_shaders_config.glsl>

	gl_Position = text.glPos;
	vertexColor = text.color;
}