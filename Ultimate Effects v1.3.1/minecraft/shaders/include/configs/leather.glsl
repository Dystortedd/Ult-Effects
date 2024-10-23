LEATHER_EFFECT(255, 0, 255) {
	leather.color.rgb *= animation(vec2(0, 0), 8.0, 1.0, 1000.0, true).rgb;
}

LEATHER_EFFECT(255, 1, 255) {
	leather.color.rgb = color_palette(vec2(16, 0), 9.0).rgb;
}

LEATHER_EFFECT(255, 2, 255) {
	leather.color.rgb *= gradient(vec2(0, 32), 5.0, 1.0, 200.0).rgb;
}

LEATHER_EFFECT(255, 3, 255) {
	leather.color.rgb *= animation(vec2(0, 16), 8.0, 16.0, 2000.0, true).rgb;
}

LEATHER_EFFECT(255, 4, 255) {
	leather.color *= color(rgba(0, 0, 0, 128));
}