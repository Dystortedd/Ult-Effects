///////////////////////
// GENERAL FUNCTIONS //
///////////////////////

#define TEXT_EFFECT(r, g, b) if(isTextColor(ivec3(r, g, b)))

void isTextShadow() {
	float comparatorIsShadow = 0.02;
	if(Position.z > 2400 && Position.z < 2400.05) comparatorIsShadow = 0.05;

    float floatIsShadow = fract(Position.z) < comparatorIsShadow ? 1.0 : 0.0;
	text.isShadow = floatIsShadow > 0.5;
    if(Position.z == 0.0 && text.isShadow) text.isShadow = false;

	if(ProjMat[3][3] == 0.0) text.isShadow = false;
}

bool isTextColor(ivec3 colorToExpect) {
	isTextShadow();
	bool colorConfirmed = false;

	vec3 mainColorToExpect = colorToExpect;
	vec3 shadowColorToExpect = colorToExpect / 4;

	bool isMainColor = (mainColorToExpect == text.color.rgb * int(1.0 * 255.5)) && !text.isShadow;
	bool isShadowColor = (shadowColorToExpect == text.color.rgb * int(1.0 * 255.5)) && text.isShadow;

	if(isShadowColor || isMainColor) colorConfirmed = true;

	return colorConfirmed;
}

//////////////////
// TEXT EFFECTS //
//////////////////

void replaceColor(vec3 color) {text.color.rgb = color;if(text.isShadow) text.color.rgb *= 0.25;}
void replaceColor(vec4 color) {text.color = vec4(color.rgb, color.a * text.color.a); if(text.isShadow) text.color.rgb *= 0.25;}

void replaceMainColor(vec3 color) {if(!text.isShadow) text.color.rgb = color;}
void replaceMainColor(vec4 color) {if(!text.isShadow) text.color = vec4(color.rgb, color.a * text.color.a);}

void replaceShadowColor(vec3 color) {if(text.isShadow) text.color.rgb = color;}
void replaceShadowColor(vec4 color) {if(text.isShadow) text.color = vec4(color.rgb, color.a * text.color.a);}

void applyRainbow(float speed) {
	float posX = ((text.glPos.x) * 3);
	float posY = ((text.glPos.y) * 3);

	text.color.rgb = ((0.6 + 0.6 * cos (6.0 * ((posX + posY) + GameTime * 300.0 * speed) + vec3(0, 23, 21))) + vec3(0.0, 0.0, 0.0));
	
	if(text.isShadow) text.color.rgb *= 0.25;
}

void applyGradient(vec3 color1, vec3 color2, float speed) {
	float posX = (text.glPos.x) * 7;
	float posY = (text.glPos.y) * 7;

	float pct = 0.6 + 0.6 * cos (6.0 * ((posX + posY) + GameTime * 300.0 * speed));
	text.color.rgb = mix(color1, color2, pct);

	if(text.isShadow) text.color.rgb *= 0.25;
}

void applyRemoveShadow() {
	if(text.isShadow) text.glPos = vec4(2,2,2,1);
	text.color.rgb = vec3(1.0);
}