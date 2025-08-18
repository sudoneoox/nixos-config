
#version 300 es
precision mediump float;

in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;

uniform int   bloomRadius    = 10;
uniform float bloomIntensity = 0.7;
uniform float bloomThreshold = 0.4;

void main() {
    vec4 base = texture(tex, v_texcoord);

    vec4 bloomThreshold4 = vec4(bloomThreshold); // w not needed
    vec2 invTextureSize = 1.0 / vec2(textureSize(tex, 0));
    float invBloomRadius = bloomRadius == 0 ? 1.0 : 1.0 / float(bloomRadius);
    float invBloomThreshold = 1.0 / max(1.0 - bloomThreshold, 1e-6);

    float samples = 0.0;
    vec4 colorSum = vec4(0.0);

    for (int x = -bloomRadius; x <= bloomRadius; ++x) {
        for (int y = -bloomRadius; y <= bloomRadius; ++y) {
            vec2 offset = vec2(x, y) * invTextureSize;
            vec4 c = texture(tex, v_texcoord + offset);
            c = max(c - bloomThreshold4, vec4(0.0));
            float strength = 1.0 - (length(offset) * invBloomRadius);
            samples += strength;
            strength *= max(max(c.r, c.g), c.b) * invBloomThreshold;
            strength *= bloomIntensity;
            colorSum += c * strength;
        }
    }

    vec4 bloom = colorSum / max(samples, 1e-6);
    fragColor = min(base + bloom, vec4(1.0));
}

