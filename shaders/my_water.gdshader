shader_type spatial;

uniform sampler2D wave_a;
uniform sampler2D wave_b;

uniform float wave_height_scale = 0.35;
uniform float wave_time_scale = 0.025;

varying vec2 vertex_uv;

float get_wave_height(vec2 uv)
{
	float height1 = texture(wave_a, TIME * wave_time_scale + uv).r;
	float height2 = texture(wave_b, TIME * wave_time_scale + uv).r;
	return (height1 + height2 * 2.0) / 2.0;
}

void vertex() {
	// Called for every vertex the material is visible on.
	
	VERTEX.y += get_wave_height(UV) * wave_height_scale;
	
}

void fragment() {
	ALBEDO = vec3(0.02, 0.45, 0.8);
}

