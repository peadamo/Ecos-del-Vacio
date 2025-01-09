shader_type sky;
uniform vec4 color_top : source_color = vec4(0.1, 0.1, 0.3, 1.0);
uniform vec4 color_bottom : source_color = vec4(0.2, 0.1, 0.4, 1.0);
uniform float UV_modifier : hint_range(0.0, 1.0, 0.1) = float(1.0);
void sky() {
    vec2 uv = SCREEN_UV;
    vec4 grad_color = mix(color_top,color_bottom, uv.y*2.0);
    COLOR = grad_color.rgb;
}


