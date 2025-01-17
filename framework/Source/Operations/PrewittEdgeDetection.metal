#include <metal_stdlib>
#include "TexelSamplingTypes.h"
#include "PrewittEdgeDetection.h"
using namespace metal;

fragment half4 prewittEdgeDetectionFragment(NearbyTexelVertexIO fragmentInput [[stage_in]],
                                       texture2d<half> inputTexture [[texture(0)]],
                                       constant PrewittEdgeDetectionUniform& uniform [[buffer(1)]])
{
    constexpr sampler quadSampler(coord::pixel);
    half3 bottomColor = inputTexture.sample(quadSampler, fragmentInput.bottomTextureCoordinate).rgb;
    half3 bottomLeftColor = inputTexture.sample(quadSampler, fragmentInput.bottomLeftTextureCoordinate).rgb;
    half3 bottomRightColor = inputTexture.sample(quadSampler, fragmentInput.bottomRightTextureCoordinate).rgb;
    half3 leftColor = inputTexture.sample(quadSampler, fragmentInput.leftTextureCoordinate).rgb;
    half3 rightColor = inputTexture.sample(quadSampler, fragmentInput.rightTextureCoordinate).rgb;
    half3 topColor = inputTexture.sample(quadSampler, fragmentInput.topTextureCoordinate).rgb;
    half3 topRightColor = inputTexture.sample(quadSampler, fragmentInput.topRightTextureCoordinate).rgb;
    half3 topLeftColor = inputTexture.sample(quadSampler, fragmentInput.topLeftTextureCoordinate).rgb;
    
    half bottomLeftIntensity = bottomLeftColor.r;
    half topRightIntensity = topRightColor.r;
    half topLeftIntensity = topLeftColor.r;
    half bottomRightIntensity = bottomRightColor.r;
    half leftIntensity = leftColor.r;
    half rightIntensity = rightColor.r;
    half bottomIntensity = bottomColor.r;
    half topIntensity = topColor.r;
    
    half h = -topLeftIntensity - topIntensity - topRightIntensity + bottomLeftIntensity + bottomIntensity + bottomRightIntensity;
    h = max(0.0h, h);
    half v = -bottomLeftIntensity - leftIntensity - topLeftIntensity + bottomRightIntensity + rightIntensity + topRightIntensity;
    v = max(0.0h, v);
    
    half mag = length(half2(h, v)) * uniform.edgeStrength;
    
    return half4(half3(mag), 1.0h);
}


/*
 varying vec2 textureCoordinate;
 varying vec2 leftTextureCoordinate;
 varying vec2 rightTextureCoordinate;
 
 varying vec2 topTextureCoordinate;
 varying vec2 topLeftTextureCoordinate;
 varying vec2 topRightTextureCoordinate;
 
 varying vec2 bottomTextureCoordinate;
 varying vec2 bottomLeftTextureCoordinate;
 varying vec2 bottomRightTextureCoordinate;
 
 uniform sampler2D inputImageTexture;
 uniform float edgeStrength;
 
 void main()
 {
 float bottomLeftIntensity = texture2D(inputImageTexture, bottomLeftTextureCoordinate).r;
 float topRightIntensity = texture2D(inputImageTexture, topRightTextureCoordinate).r;
 float topLeftIntensity = texture2D(inputImageTexture, topLeftTextureCoordinate).r;
 float bottomRightIntensity = texture2D(inputImageTexture, bottomRightTextureCoordinate).r;
 float leftIntensity = texture2D(inputImageTexture, leftTextureCoordinate).r;
 float rightIntensity = texture2D(inputImageTexture, rightTextureCoordinate).r;
 float bottomIntensity = texture2D(inputImageTexture, bottomTextureCoordinate).r;
 float topIntensity = texture2D(inputImageTexture, topTextureCoordinate).r;
 float h = -topLeftIntensity - topIntensity - topRightIntensity + bottomLeftIntensity + bottomIntensity + bottomRightIntensity;
 float v = -bottomLeftIntensity - leftIntensity - topLeftIntensity + bottomRightIntensity + rightIntensity + topRightIntensity;
 
 float mag = length(vec2(h, v)) * edgeStrength;
 
 gl_FragColor = vec4(vec3(mag), 1.0);
 }
 */
