///////////////////////
// GENERAL FUNCTIONS //
///////////////////////

#define FONT_EFFECT(x) if(isFontID(x))

bool isFontID(float idToExpect) {
	bool fontConfirmed = false;

	if(text.id == idToExpect) fontConfirmed = true;
	return fontConfirmed;
}

vec2[] corners = vec2[](
  vec2(-2, 2),
  vec2(-2,-2),
  vec2( 2,-2),
  vec2( 2, 2)
);

//////////////////
// FONT EFFECTS //
//////////////////

void screen_anchor(float x, float y) {
	text.glPos.x += x * text.glPos.w;
	text.glPos.y += y * text.glPos.w;
}



void fullscreen(float z, float zoom) {
    text.glPos = vec4(corners[text.glVertex % 4], z, 2);

    if (zoom != 0.) {
        text.glPos = vec4(corners[1 % 4], z, (1 + zoom) + (text.color.a * zoom));
    }
}


void font_waving() {
	text.uv.y += sin(text.charPos.x * 0.1 - GameTime * 7500.0) / 256.0;
}