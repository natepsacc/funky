//
//  SharedStructures.h
//  CoreDefense
//
//  Created by Connor Brewster on 10/8/15.
//  Copyright (c) 2015 Double Bit Studios. All rights reserved.
//

#ifndef SharedStructures_h
#define SharedStructures_h

#include <simd/simd.h>

typedef struct
{
    matrix_float4x4 model_matrix;
    matrix_float4x4 projection_matrix;
} uniforms_t;

typedef struct {
    vector_float3 color;
    float colorizeFactor;
} frag_uniforms_t;

typedef struct
{
    float x;
    float y;
}position_t;

#endif /* SharedStructures_h */

