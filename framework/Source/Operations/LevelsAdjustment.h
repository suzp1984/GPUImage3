//
//  LevelsAdjustment.h
//  GPUImage
//
//  Created by Jacob Su on 4/12/21.
//  Copyright © 2021 Red Queen Coder, LLC. All rights reserved.
//

#ifndef LevelsAdjustment_h
#define LevelsAdjustment_h

#import <simd/simd.h>

typedef struct
{
    vector_float3 minimum;
    vector_float3 middle;
    vector_float3 maximum;
    vector_float3 minOutput;
    vector_float3 maxOutput;
} LevelAdjustmentUniform;

#endif /* LevelsAdjustment_h */
