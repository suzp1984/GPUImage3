#include <metal_stdlib>
#include "OperationShaderTypes.h"
#include "FalseColor.h"
using namespace metal;

fragment half4 falseColorFragment(SingleInputVertexIO fragmentInput [[stage_in]],
                                  texture2d<half> inputTexture [[texture(0)]],
                                  constant FalseColorUniform& uniform [[ buffer(1) ]])
{
    constexpr sampler quadSampler;
    half4 color = inputTexture.sample(quadSampler, fragmentInput.textureCoordinate);
    float luminance = dot(color.rgb, luminanceWeighting);
    
    return half4(mix(half3(uniform.firstColor.rgb), half3(uniform.secondColor.rgb), half3(luminance)), color.a);
}
