#version 150

#moj_import <fog.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;
in vec3 Normal;

uniform sampler2D Sampler0;
uniform sampler2D Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform int FogShape;
uniform float GameTime;
uniform vec2 ScreenSize;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;

out vec3 glCornerTex1;
out vec3 glCornerTex2;
out vec3 glCornerTex3;
out vec3 glCornerTex4;

out vec3 uvCornerTex1;
out vec3 uvCornerTex2;
out vec3 uvCornerTex3;
out vec3 uvCornerTex4;

out vec4 sPos;
out float is3D;
out float fontID;
out float floatIsShadow;
out vec4 baseColor;
out vec4 lightColor;
out float isMap;

struct Text {
	float id;
	vec4 glPos;
    int glVertex;

    float alphaRead;
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

void isTextShadow() {
	is3D = 0.0;
	float comparatorIsShadow = 0.02;
	if(Position.z > 2400 && Position.z < 2400.05) comparatorIsShadow = 0.05;

    floatIsShadow = fract(Position.z) < comparatorIsShadow ? 1.0 : 0.0;

    if(Position.z == 0.0 && (floatIsShadow > 0.5)) floatIsShadow = 0.0;
	if(ProjMat[3][3] == 0.0) floatIsShadow = 0.0; is3D = 1.0;
}

#moj_import <utils.glsl>
#moj_import <effects/text.glsl>
#moj_import <effects/font.glsl>

void main() {
	isTextShadow();

	vec4 pos = vec4(Position, 1.0);
    vertexDistance = length((ModelViewMat * vec4(Position, 1.0)).xyz);
	baseColor = Color;
	lightColor = texelFetch(Sampler2, UV2 / 16, 0);
    vertexColor = vec4(1.0);

	text.id = floor((pos.y + 1000.0) / 5000.0);
	pos.y = mod(pos.y + 1000.0, 5000.0) - 1000.0;
	gl_Position = ProjMat * ModelViewMat * pos;

    text.alphaRead = baseColor.a;
	text.glPos = gl_Position;
    text.glVertex = gl_VertexID;

	// if(Position.z == 2400.0 && gl_Position.y >= 0.0) text.id *= 0.25; // Title Shadow
	// if(Position.z == 2400.0 && gl_Position.y < 0.0) text.id *= 0.5; // Subtitle Shadow

	if(Position.z == 2400.12) text.id *= 0.25; // Title
	if(Position.z == 2400.06) text.id *= 0.5; // Subtitle

	isMap = 0.0;
    if(textureSize(Sampler0, 0) != ivec2(256, 256)) isMap = 1.0;

	if(isMap < 0.5) {
		glCornerTex1 = glCornerTex2 = glCornerTex3 = glCornerTex4 = uvCornerTex1 = uvCornerTex2 = uvCornerTex3 = uvCornerTex4 = vec3(0.0);
		switch (gl_VertexID % 4) {
			case 0: glCornerTex1 = vec3(Position.xy, 1.0); uvCornerTex1 = vec3(UV0.xy, 1.0);
			case 1: glCornerTex2 = vec3(Position.xy, 1.0); uvCornerTex2 = vec3(UV0.xy, 1.0);
			case 2: glCornerTex3 = vec3(Position.xy, 1.0); uvCornerTex3 = vec3(UV0.xy, 1.0);
			case 3: glCornerTex4 = vec3(Position.xy, 1.0); uvCornerTex4 = vec3(UV0.xy, 1.0);
		}
	}

	#moj_import <configs/text.glsl>
	#moj_import <configs/font.glsl>
	gl_Position = text.glPos;

	fontID = text.id;
	sPos = gl_Position;
	texCoord0 = UV0;
}