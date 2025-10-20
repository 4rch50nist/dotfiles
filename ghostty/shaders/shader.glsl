// Original shader collected from: https://www.shadertoy.com/view/WsVSzV
// Licensed under Shadertoy's default since the original creator didn't provide any license. (CC BY NC SA 3.0)
// Slight modifications were made to give a green-ish effect.

float warp = 0.5; // simulate curvature of CRT monitor
float scan = 0.2; // simulate darkness between scanlines

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    // squared distance from center
    vec2 uv = fragCoord / iResolution.xy;
    vec2 dc = abs(0.5 - uv);
    dc *= dc;

    // warp the fragment coordinates
    uv.x -= 0.5; uv.x *= 1.0 + (dc.y * (0.5 * warp)); uv.x += 0.5;
    uv.y -= 0.5; uv.y *= 1.0 + (dc.x * (0.4 * warp)); uv.y += 0.5;

    // sample inside boundaries, otherwise set to black
    if (uv.y > 1.0 || uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0)
        fragColor = vec4(0.0, 0.0, 0.0,  0.6);
    else
    {
        // determine if we are drawing in a scanline
        float apply = abs(sin(fragCoord.y) * 0.5 * scan);

        // tint vector
        vec3 tint = vec3(0.96, 0.76, 0.91);

        // sample the texture and apply a tint
        vec3 color = texture(iChannel0, uv).rgb;

        // mix the sampled color with the tint based on scanline intensity
        fragColor = vec4(mix(color * tint, vec3(0.3), apply),1.0);
    }
}
