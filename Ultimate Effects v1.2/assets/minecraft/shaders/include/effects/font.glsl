///////////////////////
// GENERAL FUNCTIONS //
///////////////////////

#define FONT_EFFECT(x) if(isFontID(x))

bool isFontID(float idToExpect) {
	bool fontConfirmed = false;

	if(text.id == idToExpect) fontConfirmed = true;
	return fontConfirmed;
}

//////////////////
// FONT EFFECTS //
//////////////////

void screen_anchor(float x, float y) {
	text.glPos.x += x * text.glPos.w;
	text.glPos.y += y * text.glPos.w;
}

void font_waving() {
	text.uv.y += sin(text.charPos.x * 0.1 - GameTime * 7500.0) / 256.0;
}