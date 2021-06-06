#include <metal_stdlib>
#include "OperationShaderTypes.h"
#include "BlendShaderTypes.h"
#include "Pixellate.h"

using namespace metal;

fragment half4 pixellateFragment(SingleInputVertexIO fragmentInput [[stage_in]],
                                texture2d<half> inputTexture [[texture(0)]],
                                constant PixellateUniform& uniform [[buffer(1)]])
{
    float2 sampleDivisor = float2(uniform.fractionalWidthOfPixel, uniform.fractionalWidthOfPixel / uniform.aspectRatio);
    
    float2 samplePos = fragmentInput.textureCoordinate - mod(fragmentInput.textureCoordinate, sampleDivisor) + float2(0.5) * sampleDivisor;
    
    constexpr sampler quadSampler;
    return half4(inputTexture.sample(quadSampler, samplePos));
}
