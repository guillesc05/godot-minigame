shader_type canvas_item;

uniform float progress: hint_range(0.0,1.0) =0.5;
uniform vec4 wave_1_color: source_color;
uniform float wave_1_speed = -1.0;
uniform vec4 backgroundFillColor:source_color;

vec4 wave(vec2 uv, vec4 wave_color, float level, float freq, float amp, float sin_shift, float speed){
	float sinus = sin((uv.x+ sin_shift + TIME*speed) * freq) *amp;
	float shifted_level = (1.0+2.0 * amp) * level -amp;
	float threshold = step(1.0 - sinus - shifted_level, uv.y);
	return wave_color + threshold;
}


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 wave1 = wave(UV, wave_1_color, progress, 1, 0.03, 0.0, wave_1_speed);
	vec4 texCol = texture(TEXTURE, UV);
	if(wave1 != wave_1_color && texCol == backgroundFillColor){
		COLOR = wave_1_color;
	}
	
	
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
