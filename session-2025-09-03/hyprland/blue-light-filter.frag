//
// Blue light filter shader for Hyprland
// Reduces blue light by 20% (adjust the 0.8 value to make it warmer/cooler)
//

precision mediump float;
varying vec2 v_texcoord;
uniform sampler2D tex;

void main() {
    vec4 pixColor = texture2D(tex, v_texcoord);
    
    // Reduce blue channel intensity (0.8 = 20% reduction, 0.7 = 30% reduction)
    pixColor[2] *= 0.7;
    
    gl_FragColor = pixColor;
}
