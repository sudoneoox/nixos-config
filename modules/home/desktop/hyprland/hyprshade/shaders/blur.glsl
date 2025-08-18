
#version 300 es
precision mediump float;

in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;

uniform int blurRadius = 1;

void main() {
    if (blurRadius <= 0) {
        fragColor = texture(tex, v_texcoord);
        return;
    }

    vec2 invTextureSize = 1.0 / vec2(textureSize(tex, 0));
    float invBlurRadius = 1.0 / float(blurRadius);

    float samples = 0.0;
    vec4 colorSum = vec4(0.0);

    for (int x = -blurRadius; x <= blurRadius; ++x) {
        for (int y = -blurRadius; y <= blurRadius; ++y) {
            vec2 offset = vec2(x, y) * invTextureSize;
            float strength = 1.0 - (length(offset) * invBlurRadius);
            samples += strength;
            vec2 coords = v_texcoord + offset;
            colorSum += texture(tex, coords) * strength;
        }
    }

    colorSum /= max(samples, 1e-6);
    fragColor = colorSum;
}

