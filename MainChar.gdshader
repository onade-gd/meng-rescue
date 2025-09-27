shader_type canvas_item;

//Hat
uniform vec4 jacket_color : source_color;
uniform vec4 jacket_replace_color : source_color;
uniform float jacket_color_threshold : hint_range(0.0, 1.0, 0.001);

//Hair
uniform vec4 shadow_color : source_color;
uniform vec4 shadow_replace_color : source_color;
uniform float shadow_color_threshold : hint_range(0.0, 1.0, 0.001);

//Skin
uniform vec4 outline_color : source_color;
uniform vec4 outline_replace_color : source_color;
uniform float outline_color_threshold : hint_range(0.0, 1.0, 0.001);

uniform vec4 shine_color : source_color;
uniform vec4 shine_replace_color : source_color;
uniform float shine_color_threshold : hint_range(0.0, 1.0, 0.001);

//Clothes
uniform vec4 bucket_color : source_color;
uniform vec4 bucket_replace_color : source_color;
uniform float bucket_color_threshold : hint_range(0.0, 1.0, 0.001);

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 tex_color = texture(TEXTURE, UV);
	
	float jacket_distance = length(tex_color.rgb - jacket_color.rgb);
	float shadow_distance = length(tex_color.rgb - shadow_color.rgb);
	float outline_distance = length(tex_color.rgb - outline_color.rgb);
	float shine_distance = length(tex_color.rgb - shine_color.rgb);
	float bucket_distance = length(tex_color.rgb - bucket_color.rgb);
	
	if(jacket_distance < jacket_color_threshold){
		tex_color = jacket_replace_color;
	}else if(shadow_distance < shadow_color_threshold){
		tex_color = shadow_replace_color;
	}else if(outline_distance < outline_color_threshold){
		tex_color = outline_replace_color;
	}else if(shine_distance < shine_color_threshold){
		tex_color = shine_replace_color;
	}else if(bucket_distance < bucket_color_threshold){
		tex_color = bucket_replace_color;
	}
	
	COLOR = tex_color;
}