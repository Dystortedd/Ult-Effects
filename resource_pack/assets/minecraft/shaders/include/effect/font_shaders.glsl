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

void applyAnchor(float x, float y) {
	text.glPos.x += x * text.glPos.w;
	text.glPos.y += y * text.glPos.w;
}