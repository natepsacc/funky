//
//  MatrixUtility.h
//  CoreDefense
//
//  Created by Connor Brewster on 10/8/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#ifndef MatrixUtility_h
#define MatrixUtility_h

#import <simd/simd.h>

static matrix_float4x4 matrix_from_orthographic(const float left, const float right, const float bottom, const float top, const float near, const float far) {
    float ral = right + left;
    float rsl = right - left;
    float tab = top + bottom;
    float tsb = top - bottom;
    float fan = far + near;
    float fsn = far - near;
    
    matrix_float4x4 m = {
        .columns[0] = { 2.0f / rsl, 0.0f, 0.0f, 0.0f },
        .columns[1] = { 0.0f, 2.0f / tsb, 0.0f, 0.0f },
        .columns[2] = { 0.0f, 0.0f, -2.0f / fsn, 1.0f },
        .columns[3] = { -ral / rsl, -tab / tsb, -fan / fsn, 1.0f }
    };
    
    return m;
}

static matrix_float4x4 matrix_from_translation(float x, float y, float z)
{
    matrix_float4x4 m = matrix_identity_float4x4;
    m.columns[3] = (vector_float4) { x, y, z, 1.0 };
    return m;
}

static matrix_float4x4 matrix_from_scale(float scale) {
    matrix_float4x4 m = {
        .columns[0] = { scale, 0.0f, 0.0f, 0.0f },
        .columns[1] = { 0.0f, scale, 0.0f, 0.0f },
        .columns[2] = { 0.0f, 0.0f, scale, 1.0f },
        .columns[3] = { 0.0f, 0.0f, 0.0f, 1.0f }
    };
    return m;
}

static matrix_float4x4 matrix_from_rotation(float radians, float x, float y, float z)
{
    vector_float3 v = vector_normalize(((vector_float3){x, y, z}));
    float cos = cosf(radians);
    float cosp = 1.0f - cos;
    float sin = sinf(radians);
    
    matrix_float4x4 m = {
        .columns[0] = {
            cos + cosp * v.x * v.x,
            cosp * v.x * v.y + v.z * sin,
            cosp * v.x * v.z - v.y * sin,
            0.0f,
        },
        
        .columns[1] = {
            cosp * v.x * v.y - v.z * sin,
            cos + cosp * v.y * v.y,
            cosp * v.y * v.z + v.x * sin,
            0.0f,
        },
        
        .columns[2] = {
            cosp * v.x * v.z + v.y * sin,
            cosp * v.y * v.z - v.x * sin,
            cos + cosp * v.z * v.z,
            0.0f,
        },
        
        .columns[3] = { 0.0f, 0.0f, 0.0f, 1.0f
        }
    };
    return m;
}

#endif /* MatrixUtility_h */
