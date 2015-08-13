#ifdef GL_ES
precision mediump float;
#endif

varying vec2 v_texCoord;
varying vec4 v_fragmentColor;
uniform sampler2D u_texture;
//uniform float intensity_offset = 1.0;
//uniform float intensity_scale = 2.0;

void main(void)
{
    vec4 texColor = texture2D(u_texture, v_texCoord);
    // gray value
    float gray = dot(texColor.rgb, vec3(0.3f, 0.59f, 0.11f));
    // new gray
    float new_intensity = (gray + 1) * 2;
    
    // fixed color
    gl_FragColor = texColor * new_intensity;
}