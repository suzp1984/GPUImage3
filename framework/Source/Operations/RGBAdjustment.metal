#include <metal_stdlib>
#include "OperationShaderTypes.h"
#include "RGBAdjustment.h"
using namespace metal;

fragment half4 rgbAdjustmentFragment(SingleInputVertexIO fragmentInput [[stage_in]],
                             texture2d<half> inputTexture [[texture(0)]],
                             constant RGBAdjustmentUniform& uniform [[ buffer(1) ]])
{
    constexpr sampler quadSampler;
    half4 color = inputTexture.sample(quadSampler, fragmentInput.textureCoordinate);
    
    return half4(color.r * uniform.redAdjustment,
                 color.g * uniform.greenAdjustment,
                 color.b * uniform.blueAdjustment,
                 color.a);
}
