//
//  Vignette.h
//  GPUImage
//
//  Created by Jacob Su on 6/13/21.
//  Copyright © 2021 Red Queen Coder, LLC. All rights reserved.
//

#ifndef Vignette_h
#define Vignette_h

typedef struct {
    vector_float2 vignetteCenter;
    vector_float3 vignetteColor;
    float vignetteStart;
    float vignetteEnd;
} VignetteUniform;

#endif /* Vignette_h */
