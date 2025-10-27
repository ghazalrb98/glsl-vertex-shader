uniform float time;

varying vec3 vNormal;
varying vec3 vPosition;
varying vec3 vColor;

float inverseLerp(float v, float minValue, float maxValue) {
  return (v - minValue) / (maxValue - minValue);
}

float remap(float v, float inMin, float inMax, float outMin, float outMax) {
  float t = inverseLerp(v, inMin, inMax);
  return mix(outMin, outMax, t);
}

void main() {
    vec3 localSpacePosition = position;

    float t = sin(localSpacePosition.y * 20.0 + time * 5.0);
    t = remap(t, -1.0, 1.0, 0.0, 0.2);
    localSpacePosition += normal * t;    // the displacement should be in the direction of normal
    
    gl_Position = projectionMatrix * modelViewMatrix * vec4(localSpacePosition, 1.0);

    vNormal = (modelMatrix * vec4(normal, 0.0)).xyz;
    vPosition = (modelMatrix * vec4(localSpacePosition, 1.0)).xyz;

    vec3 red = vec3(1.0, 0.0, 0.0);
    vec3 blue = vec3(0.0, 1.0, 0.0);
    vColor = mix(red, blue, smoothstep(0.0, 0.2, t));
}