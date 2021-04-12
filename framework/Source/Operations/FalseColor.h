//
//  FalseColor.h
//  GPUImage
//
//  Created by Jacob Su on 4/12/21.
//  Copyright © 2021 Red Queen Coder, LLC. All rights reserved.
//

#ifndef FalseColor_h
#define FalseColor_h

#import <simd/simd.h>

typedef struct
{
    vector_float4 firstColor;
    vector_float4 secondColor;
} FalseColorUniform;

#endif /* FalseColor_h */
