shader_type canvas_item;
render_mode unshaded, skip_vertex_transform;

uniform sampler2D screen_texture: hint_screen_texture, filter_linear_mipmap;
uniform vec2 screen_size = vec2(1600.0, 900.0); // Match your game resolution
uniform float brightness_boost = 2.0; // Compensates for masking darkness
uniform float bleed = 0.5;            // How much each channel bleeds into neighbors (0.0–1.0)

void fragment() {
    vec2 pixel = SCREEN_UV * screen_size;
    float offset = 1.0 / screen_size.x;
    vec4 base = texture(screen_texture, SCREEN_UV);
    float r   = texture(screen_texture, SCREEN_UV + vec2(-offset, 0.0)).r;
    float g   = base.g;
    float b   = texture(screen_texture, SCREEN_UV + vec2( offset, 0.0)).b;
    // Smooth sub-pixel masks
    float sp = fract(pixel.x / 3.0) * 3.0;
    float r_mask = smoothstep(0.0, 0.5, sp) - smoothstep(0.5, 1.0, sp);
    float g_mask = smoothstep(1.0, 1.5, sp) - smoothstep(1.5, 2.0, sp);
    float b_mask = smoothstep(2.0, 2.5, sp) - smoothstep(2.5, 3.0, sp);
    // Each channel: own column + equal bleed from both immediate neighbors
    float r_out = r * r_mask + r * g_mask * bleed;
    float g_out = g * g_mask + g * r_mask * bleed + g * b_mask * bleed;
    float b_out = b * b_mask + b * g_mask * bleed;
    vec3 crt_color = vec3(r_out, g_out, b_out) * brightness_boost;
    COLOR = vec4(crt_color, base.a);
}