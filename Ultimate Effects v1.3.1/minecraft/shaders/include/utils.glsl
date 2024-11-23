////////////////
// MATH UTILS //
////////////////

#define PI 3.14159265359
#define TAU 6.28318530718
#define PHI 1.61803398875
#define E 2.71828182846
#define SQRT_2 1.41421356237
#define SQRT_3 1.73205080757

/////////////////
// COLOR UTILS //
/////////////////

vec4 HeatMapColor(float value, float minValue, float maxValue)
{
    vec4[] colors = vec4[](
        vec4(0.32, 0.00, 0.32, 1.00),
        vec4(0.00, 0.00, 1.00, 1.00),
        vec4(0.00, 1.00, 0.00, 1.00),
        vec4(1.00, 1.00, 0.00, 1.00),
        vec4(1.00, 0.60, 0.00, 1.00),
        vec4(1.00, 0.00, 0.00, 1.00)
    );
    float ratio= 5. * (value / (maxValue - minValue));
    int indexMin = int(floor(ratio));
    int indexMax= int(min(indexMin + 1,5));
    return mix(colors[indexMin], colors[indexMax], ratio - indexMin);
}


vec3 hsvToRgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

vec3 rgbToHsv(vec3 c)
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec4 rgba(int r, int g, int b, int a) {
    return vec4(r / 255.0, g / 255.0, b / 255.0, a / 255.0);
}

vec3 rgb(int r, int g, int b) {
    return vec3(r / 255.0, g / 255.0, b / 255.0);
}

vec3 hsv(int h, int s, int v) {
    vec3 c = vec3(h / 360.0, s / 100.0, v / 100.0);
    return hsvToRgb(c);
}

//////////////////////////
// RANDOM / NOISE UTILS //
//////////////////////////

float random(vec3 seed) {
    return fract(sin(dot(seed, vec3(12.9898,78.233,85.1472))) * 43758.5453);
}

float random(vec2 seed) {
    return fract(sin(dot(seed, vec2(12.9898,78.233))) * 43758.5453);
}

float random(float seed) {
    return fract(sin(seed) * 43758.5453);
}

float noise(float n) {
    float i = floor(n);
    float f = fract(n);
    return mix(random(i), random(i + 1.0), smoothstep(0.0, 1.0, f));
}

float noise(vec2 p){
	vec2 ip = floor(p);
	vec2 u = fract(p);
	u = u*u*(3.0-2.0*u);
	
	float res = mix(
		mix(random(ip),random(ip+vec2(1.0,0.0)),u.x),
		mix(random(ip+vec2(0.0,1.0)),random(ip+vec2(1.0,1.0)),u.x),u.y);
	return res*res;
}

float noise(vec3 p){
    vec3 ip = floor(p);
	vec3 u = fract(p);
	u = u*u*(3.0-2.0*u);
	
	float res = mix(mix(
		mix(random(ip+vec3(0.0,0.0,0.0)),random(ip+vec3(1.0,0.0,0.0)),u.x),
		mix(random(ip+vec3(0.0,1.0,0.0)),random(ip+vec3(1.0,1.0,0.0)),u.x),u.y),
        mix(
		mix(random(ip+vec3(0.0,0.0,1.0)),random(ip+vec3(1.0,0.0,1.0)),u.x),
		mix(random(ip+vec3(0.0,1.0,1.0)),random(ip+vec3(1.0,1.0,1.0)),u.x),u.y),u.z);
	return res*res;
}