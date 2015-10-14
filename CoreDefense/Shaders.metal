//
//  Shaders.metal
//  CoreDefense
//
//  Created by Connor Brewster on 10/8/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#include <metal_stdlib>
#include <simd/simd.h>
#include "CDSharedStructures.h"

using namespace metal;

struct VertexInOut
{
    float4  position [[ position ]];
    float2  uv;
};

vertex VertexInOut passThroughVertex(uint vid                         [[ vertex_id ]],
                                     constant packed_float4* position [[ buffer(0) ]],
                                     constant packed_float2* uv       [[ buffer(1) ]],
                                     constant uniforms_t& uniforms    [[ buffer(2) ]])
{
    VertexInOut outVertex;
    float4 in_position = float4(position[vid]);
    outVertex.position = uniforms.projection_matrix * uniforms.model_matrix * in_position;
    outVertex.uv = uv[vid];
    
    return outVertex;
};

fragment half4 passThroughFragment(VertexInOut inFrag                 [[ stage_in ]],
                                   texture2d<float> tex2D             [[ texture(0) ]],
                                   constant frag_uniforms_t& uniforms [[ buffer(0) ]])
{
    constexpr sampler s(coord::normalized,
                        address::repeat,
                        filter::linear);
    
    float4 texColor = tex2D.sample(s, inFrag.uv);
    
    float3 color = uniforms.color;
    float colorizeFactor = uniforms.colorizeFactor;
    
    float3 result = (colorizeFactor * color) + ((1.0 - colorizeFactor) * texColor.rgb);
        
    return half4(float4(result, texColor.a));
};

fragment half4 whiteFragment(VertexInOut inFrag                 [[ stage_in ]],
                                   constant frag_uniforms_t& uniforms [[ buffer(0) ]])
{
    constexpr sampler s(coord::normalized,
                        address::repeat,
                        filter::linear);
    
    float4 texColor = float4(1.0f, 1.0f, 1.0f, 1.0f);
    
    float3 color = uniforms.color;
    float colorizeFactor = uniforms.colorizeFactor;
    
    float3 result = (colorizeFactor * color) + ((1.0 - colorizeFactor) * texColor.rgb);
    
    return half4(float4(result, texColor.a));
};


