shader_type spatial;

uniform vec2 center;
uniform float time;                           // Tiempo para animar las ondas
uniform float wave_speed : hint_range(0.0, 5.0) = 1.0; // Velocidad de las ondas
uniform float wave_frequency : hint_range(0.0, 10.0) = 3.0; // Frecuencia de las ondas
uniform float wave_amplitude : hint_range(0.0, 1.0) = 0.05;  // Amplitud de las ondas
uniform sampler2D normal_roughness_tex_frg_6 : hint_normal_roughness_texture;
uniform sampler2D tex_frg_2 : hint_normal;
void fragment() {
	vec2 n_out4p0;
// UVPolarCoord:4
	vec2 n_in4p1 = vec2(0.50000, 0.50000);
	float n_in4p2 = 1.00000;
	float n_in4p3 = 1.00000;
	{
		vec2 __dir = UV - n_in4p1;
		float __radius = length(__dir) * 2.0;
		float __angle = atan(__dir.y, __dir.x) * 1.0 / (PI * 2.0);
		n_out4p0 = vec2(__radius * n_in4p2, __angle * n_in4p3);
	}
	
	
	vec4 n_out6p0;
// Texture2D:6
	{
		vec3 _normal = texture(normal_roughness_tex_frg_6, UV).rgb;
		n_out6p0 = vec4(_normal, 1.0);
	}
	
	
	
	
	
	
	
    vec2 uv = FRAGCOORD.xy; // Coordenadas del fragmento
    float dist = distance(n_out4p0, center); // Distancia al centro
    float wave = sin(dist * wave_frequency - TIME * wave_speed) * wave_amplitude;
    ALBEDO = (vec3(0.0, 0.5, 1.0) + wave); // Color con efecto de onda
	
	
	NORMAL_MAP = texture(tex_frg_2,uv);
}
