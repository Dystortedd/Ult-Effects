#define TEXT_EFFECT(r, g, b) if(isTextColor(vec3(r, g, b)))

///////////////////////
// GENERAL FUNCTIONS //
///////////////////////

bool isTextColor(vec3 colorToExpect) {
	bool colorConfirmed = false;

	vec3 mainColorToExpect = colorToExpect;
	vec3 shadowColorToExpect = colorToExpect / 4;
	vec3 shadowColorToExpect3D = floor(colorToExpect / 4);

	bool isMainColor = (mainColorToExpect == text.color.rgb * int(1.0 * 255.5)) && !text.isShadow;
	bool isShadowColor = (shadowColorToExpect3D == text.color.rgb * int(1.0 * 255.5)) && text.isShadow;
	bool isShadowColor3D = (shadowColorToExpect3D == text.color.rgb * int(1.0 * 255.5)) && (is3D == 1.0);

	if(isShadowColor || isMainColor || isShadowColor3D) colorConfirmed = true;
	if(is3D == 1.0 && isShadowColor3D) text.isShadow = true;

	return colorConfirmed;
}

//////////////////
// TEXT EFFECTS //
//////////////////

void replace_color(vec3 color) {text.color.rgb = color;if(text.isShadow) text.color.rgb *= 0.25;}
void replaceColor(vec4 color) {text.color = vec4(color.rgb, color.a * text.color.a); if(text.isShadow) text.color.rgb *= 0.25;}

void replace_main_color(vec3 color) {if(!text.isShadow) text.color.rgb = color;}
void replace_main_color(vec4 color) {if(!text.isShadow) text.color = vec4(color.rgb, color.a * text.color.a);}

void replace_shadow_color(vec3 color) {if(text.isShadow) text.color.rgb = color;}
void replace_shadow_color(vec4 color) {if(text.isShadow) text.color = vec4(color.rgb, color.a * text.color.a);}

void rainbow(float speed) {
	text.color.rgb = hsvToRgb(vec3(0.005 * (text.pos.x + text.pos.y) - GameTime * 300.0, 0.8, 1.0));
	
	if(text.isShadow) text.color.rgb *= 0.25;
}

void animated_gradient(vec3 color1, vec3 color2, float speed) {
    float rotationAngle = 0.08 * (text.pos.x + text.pos.y) - GameTime * 600.0 * speed * PI;
    float t = (sin(rotationAngle) + 1.0) * 0.5;
    vec3 rainbowColor = mix(color1, color2, t);

    text.color.rgb = rainbowColor;
    if(text.isShadow) text.color.rgb *= 0.25;
}

void fade(vec3 color1, vec3 color2, float speed) {
    text.color.rgb = mix(color1, color2, sin(GameTime * 600.0 * speed * PI) * 0.5 + 0.5);

	if(text.isShadow) text.color.rgb *= 0.25;
}

void fade(vec4 color1, vec4 color2, float speed) {
    text.color = mix(vec4(color1.rgb, color1.a * text.color.a), vec4(color2.rgb, color2.a * text.color.a), sin(GameTime * 600.0 * speed * PI) * 0.5 + 0.5);

	if(text.isShadow) text.color.rgb *= 0.25;
}

void waving(float speed, float frequency) {
    text.uv.y += sin(text.charPos.x * 0.1 - GameTime * 7500.0) / 256.0;
}

void iterating(float speed, float space) {
    float x = mod(text.charPos.x * 0.4 - GameTime * 18000.0 * speed, (5.0 * space) * TAU); if(x > TAU) x = TAU;

	text.uv.y += (-cos(x) * 0.5 + 0.5) / 256.0;
}

void metalic() {
    if(text.pixelPos.y > 3) text.color.rgb = text.color.rgb * 0.7;
    if(text.pixelPos.y == 3) text.color.rgb = text.color.rgb + 0.25;
    if(text.pixelPos.y < 3) text.color.rgb = text.color.rgb;

    if(text.isShadow) text.color.rgb *= 0.25;
}

void remove_shadow() {
	if(text.isShadow) text.color.a = 0.0;
}