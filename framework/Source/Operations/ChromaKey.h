//
//  ChromaKey.h
//  GPUImage
//
//  Created by Jacob Su on 6/13/21.
//  Copyright © 2021 Red Queen Coder, LLC. All rights reserved.
//

#ifndef ChromaKey_h
#define ChromaKey_h

typedef struct
{
    float thresholdSensitivity;
    float smoothing;
    vector_float4 colorToReplace;
} ChromaKeyUniform;

#endif /* ChromaKey_h */
