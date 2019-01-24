// basic.vert

precision highp float;
attribute vec3 aVertexPosition;
attribute vec2 aTextureCoord;
attribute vec3 aNormal;

uniform mat4 uModelMatrix;
uniform mat4 uViewMatrix;
uniform mat4 uProjectionMatrix;
uniform vec2 uViewport;


uniform sampler2D textureMap;
uniform float uGap;
uniform float uPercent;

varying vec2 vTextureCoord;
varying vec3 vNormal;
varying vec3 vColor;

const float radius = 0.005;

void main(void) {
	vColor           = texture2D(textureMap, aTextureCoord).rgb;
	vec3 position    = aVertexPosition;
	position.y       = vColor.r * 0.2;

	float r = length(position.xz);
	vec2 xz = normalize(position.xz);
	xz *= r + uGap * uPercent;

	position.xz = xz;
	
	gl_Position      = uProjectionMatrix * uViewMatrix * uModelMatrix * vec4(position, 1.0);
	vTextureCoord    = aTextureCoord;
	vNormal          = aNormal;
	
	float distOffset = uViewport.y * uProjectionMatrix[1][1] * radius / gl_Position.w;
	gl_PointSize     = distOffset * (1.0 + aNormal.x * 0.25);
}