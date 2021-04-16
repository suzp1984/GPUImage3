//
//  HighlightAndShadowTint.h
//  GPUImage
//
//  Created by Jacob Su on 4/16/21.
//  Copyright © 2021 Red Queen Coder, LLC. All rights reserved.
//

#ifndef HighlightAndShadowTint_h
#define HighlightAndShadowTint_h

#import <simd/simd.h>

typedef struct
{
    float shadowTintIntensity;
    float highlightTintIntensity;
    vector_float3 shadowTintColor;
    vector_float3 highlightTintColor;
} HighlightShadowTintUniform;

#endif /* HighlightAndShadowTint_h */
