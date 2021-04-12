#include <metal_stdlib>
#include "OperationShaderTypes.h"
#include "SaturationAdjustment.h"
using namespace metal;

fragment half4 saturationFragment(SingleInputVertexIO fragmentInput [[stage_in]],
                                texture2d<half> inputTexture [[texture(0)]],
                                constant SaturationUniform& uniform [[ buffer(1) ]])
{
    constexpr sampler quadSampler;
    half4 color = inputTexture.sample(quadSampler, fragmentInput.textureCoordinate);

    half luminance = dot(color.rgb, luminanceWeighting);

    return half4(mix(half3(luminance), color.rgb, half(uniform.saturation)), color.a);
}
