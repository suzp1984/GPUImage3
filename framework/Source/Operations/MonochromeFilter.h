//
//  MonochromeFilter.h
//  GPUImage
//
//  Created by Jacob Su on 4/12/21.
//  Copyright © 2021 Red Queen Coder, LLC. All rights reserved.
//

#ifndef MonochromeFilter_h
#define MonochromeFilter_h

#import <simd/simd.h>

typedef struct
{
    float intensity;
    vector_float3 filterColor;
} MonochromeUniform;

#endif /* MonochromeFilter_h */
