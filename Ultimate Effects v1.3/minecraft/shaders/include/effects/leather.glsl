#define LEATHER_EFFECT(r, g, b) if(isLeatherColor(vec3(r, g, b)))

///////////////////////
// GENERAL FUNCTIONS //
///////////////////////

bool isLeatherColor(vec3 colorToExpect) {
	bool colorConfirmed = false;

	if(baseColor.rgb * int(1.0 * 255.5) == colorToExpect) {
		colorConfirmed = true;
		leather.applyColor = 0.0;
	}

	return colorConfirmed;
}

/////////////////////
// LEATHER EFFECTS //
/////////////////////

vec4 color(vec4 col) {
	vec4 color = vec4(mix(leather.color.rgb, col.rgb, col.a), mix(leather.color.a, col.a, col.a));

    return color;
}

vec3 color(vec3 col) {
	vec3 color = mix(leather.color.rgb, col.rgb, leather.color.a);

    return color;
}

vec4 color_palette(vec2 height, float frameCount) {
	vec2 ts = vec2(textureSize(Sampler0, 0));
	vec4 rgb = texture(Sampler0, leather.uv);

	vec4 color = texture(Sampler0, vec2(height.x + round(0.8 * rgb.x * frameCount + 0.25), height.y) / ts);

	return color;
}

vec4 gradient(vec2 height, float frameCount, float size, float speed) {
	vec2 ts = vec2(textureSize(Sampler0, 0));
	vec2 uv = leather.uv * ts;

	float t = GameTime * speed + (uv.x - uv.y) / 32.0;
	float angle = sin(fract(t) * (3.141593 / 2.0));
	angle *= angle;
	float colorIndex0 = mod(floor(t), frameCount) * size;
	float colorIndex1 = mod(floor(t) + 1.0, frameCount) * size;

	vec4 color0 = texture(Sampler0, (mod(uv, size) + vec2(height.x + colorIndex0, height.y)) / ts);
	vec4 color1 = texture(Sampler0, (mod(uv, size) + vec2(height.x + colorIndex1, height.y)) / ts);

	vec4 color = mix(color0, color1, angle);

	return color;
}

vec4 animation(vec2 height, float frameCount, float size, float speed, bool interpolation) {
	float t = GameTime * speed;
	float t2 = fract(t);
	float colorIndex0 = mod(floor(t), frameCount) * size;
	float colorIndex1 = mod(floor(t) + 1.0, frameCount) * size;

	vec2 ts = vec2(textureSize(Sampler0, 0));
	vec2 uv = leather.uv * ts;

	vec4 color0 = texture(Sampler0, (mod(uv, size) + vec2(height.x + colorIndex0, height.y)) / ts);
	vec4 color1 = texture(Sampler0, (mod(uv, size) + vec2(height.x + colorIndex1, height.y)) / ts);

	vec4 color = mix(color0, color1, t2);

	if (interpolation) {
		return color;
	} else {
		return color1;
	}
}

vec4 texture(vec2 topLeftCorner, vec2 texSize, float size) {
    vec2 ts = vec2(textureSize(Sampler0, 0));
    vec2 uv = mod((leather.uv * ts / size), vec2(1.0)) * (texSize / ts) + (topLeftCorner / ts);

    vec4 texture = texture(Sampler0, uv);

	vec4 color = vec4(mix(leather.color.rgb, texture.rgb, texture.a), mix(leather.color.a, texture.a, texture.a));

	if(leather.color.a < 1.0/255) color.a = 0.0;

    return color;
}