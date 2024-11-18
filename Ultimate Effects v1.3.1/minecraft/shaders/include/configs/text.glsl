TEXT_EFFECT(255, 0, 255) {
	rainbow(1.0);
}

TEXT_EFFECT(255, 4, 255) {
	animated_gradient(rgb(248, 20, 20), rgb(248, 120, 20), 1.0);
}

TEXT_EFFECT(255, 8, 255) {
	animated_gradient(rgb(13, 255, 253), rgb(13, 255, 65), 1.0);
}

TEXT_EFFECT(255, 12, 255) {
	fade(rgb(13, 255, 65), rgb(13, 255, 253), 2.0);
	waving(1.0, 1.0);
}

TEXT_EFFECT(255, 16, 255) {
    scrollingMasked(0.25,0,0.6);
	animated_gradient(rgb(24, 7, 131), rgb(157, 26, 135), 1.5,0.3,0.8);
}
TEXT_EFFECT(255, 20, 255) {
    scrollingMasked(0.25,0,-1.25);
	animated_gradient(rgb(36, 69, 89), rgb(26, 16, 61), -1,0.25,0.5);
}
TEXT_EFFECT(255, 24, 255) {
    scrollingMasked(0.25,0,2.25);
	animated_gradient(rgb(21, 73, 71), rgb(36, 26, 81), -0.5,0.1,0.3);
}
TEXT_EFFECT(255, 28, 255) {
    waving(0.1,0.1);
	animated_gradient(rgb(26, 148, 157) * 2, rgb(80, 26, 157) * 2, -0.5,0.1,0.3);
    alphaGradient(0.5,0,1,0.05,0.5);
}
TEXT_EFFECT(255, 32, 255) {
    waving(0.1,0.1);
	animated_gradient(rgb(26, 148, 157) * 2, rgb(80, 26, 157) * 2, -0.3,0.12,0.5);
    alphaGradient(0.5,0.1,0.5,0.03,0.2);
}