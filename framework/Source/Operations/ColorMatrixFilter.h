//
//  Header.h
//  GPUImage
//
//  Created by Jacob Su on 4/15/21.
//  Copyright © 2021 Red Queen Coder, LLC. All rights reserved.
//

#ifndef Header_h
#define Header_h

#import <simd/simd.h>

typedef struct
{
    float intensity;
    matrix_float4x4 colorMatrix;
} ColorMatrixUniform;

#endif /* Header_h */
