//
//  CDSprite.m
//  CoreDefense
//
//  Created by Connor Brewster on 10/8/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import <simd/simd.h>

#import "CDSprite.h"
#import "CDMetalManager.h"
#import "MatrixUtility.h"

static const simd::float2 kQuadUV[4] =
{
    { 0.0f, 0.0f },
    { 0.0f, 1.0f },
    { 1.0f, 0.0f },
    { 1.0f, 1.0f }
};
static const uint32_t kCntQuadTexCoords = 4;
static const uint32_t kSzQuadVertices  = kCntQuadTexCoords * sizeof(simd::float4);
static const uint32_t kSzQuadUVVertices  = kCntQuadTexCoords * sizeof(simd::float2);

@implementation CDSprite {
    id <MTLBuffer> _vertexBuffer;
    id <MTLBuffer> _uvBuffer;
    id <MTLBuffer> _frameVertexUniformBuffers[kMaxInflightBuffers];
    id <MTLBuffer> _frameFragmentUniformBuffers[kMaxInflightBuffers];
    simd::float4 kQuadVertices[4];
    
    CDMetalManager* _manager;
}

- (void)setFrame:(CGRect)frame {
    _frame = frame;
    [self generateVerts];
    _vertexBuffer = [[[CDMetalManager sharedManager] device] newBufferWithBytes:kQuadVertices length:kSzQuadVertices options:MTLResourceOptionCPUCacheModeDefault];
}

- (void)generateVerts {
    CGSize size = _frame.size;
    simd::float4 newVerts[4]
    {
        { - (float)size.width / 2.0f, - (float)size.height / 2.0f, 0.0f, 1.0f },
        { - (float)size.width / 2.0f,   (float)size.height / 2.0f, 0.0f, 1.0f },
        {   (float)size.width / 2.0f, - (float)size.height / 2.0f, 0.0f, 1.0f },
        {   (float)size.width / 2.0f,   (float)size.height / 2.0f, 0.0f, 1.0f }
    };
    memcpy(kQuadVertices, newVerts, kSzQuadVertices);
}

- (id)initWithImageNamed:(NSString*)name {
    if (self = [super init]) {
        _manager = [CDMetalManager sharedManager];

        self.texture = [[_manager textureManager] getTextureFromName:name];
        [self setFrame:CGRectMake(0.0f, 0.0f, self.texture.widthPoints, self.texture.heightPoints)];
        [self setupPipelineState];
        [self setupBuffers];
        _color = [UIColor whiteColor];
        _colorizeFactor = 0.0f;
    }
    return self;
}


- (void)setupBuffers {
    _vertexBuffer = [[_manager device] newBufferWithBytes:kQuadVertices length:kSzQuadVertices options:MTLResourceOptionCPUCacheModeDefault];
    _uvBuffer = [[_manager device] newBufferWithBytes:kQuadUV length:kSzQuadUVVertices options:MTLResourceOptionCPUCacheModeDefault];
    // Create a uniform buffer that we'll dynamicall update each frame.
    for (uint8_t i = 0; i < kMaxInflightBuffers; i++) {
        _frameVertexUniformBuffers[i] = [[_manager device] newBufferWithLength:sizeof(uniforms_t) options:0];
    }
    
    for (uint8_t i = 0; i < kMaxInflightBuffers; i++) {
        _frameFragmentUniformBuffers[i] = [[_manager device] newBufferWithLength:sizeof(frag_uniforms_t) options:0];
    }
}

- (void)setupPipelineState {
    _pipelineState = [[_manager pipelineManager] getPipelineStateWithKey:@"passThrough"];
}

- (void)update:(float)dt {
    uniforms_t *vertexUniformData = (uniforms_t *)[_frameVertexUniformBuffers[[_manager constantDataBufferIndex]] contents];
    vertexUniformData->model_matrix = [self getTranslation];
    vertexUniformData->projection_matrix = [_manager orthograph];
    
    frag_uniforms_t *fragmentUniformData = (frag_uniforms_t *)[_frameFragmentUniformBuffers[[_manager constantDataBufferIndex]] contents];
    CGFloat r, g, b;
    [_color getRed:&r green:&g blue:&b alpha:NULL];
    fragmentUniformData->color = vector3((float)r, (float)g, (float)b);
    fragmentUniformData->colorizeFactor = _colorizeFactor;
    
    [super update:dt];
}

- (void)drawWithEndcoder:(id <MTLRenderCommandEncoder>)encoder {
    [encoder pushDebugGroup:@"DrawSprite"];
    [encoder setRenderPipelineState:_pipelineState];
    // TODO use semaphore to adjust offsets
    [encoder setVertexBuffer:_vertexBuffer offset:0 atIndex:0];
    [encoder setVertexBuffer:_uvBuffer offset:0 atIndex:1];
    [encoder setVertexBuffer:_frameVertexUniformBuffers[_manager.constantDataBufferIndex] offset:0 atIndex:2];
    
    [encoder setFragmentTexture:_texture.metalTexture atIndex:0];
    [encoder setFragmentBuffer:_frameFragmentUniformBuffers[_manager.constantDataBufferIndex] offset:0 atIndex:0];

    
    [encoder drawPrimitives:MTLPrimitiveTypeTriangleStrip vertexStart:0 vertexCount:4];
    [encoder popDebugGroup];
    // Draw self first, then draw children
    [super drawWithEndcoder:encoder];
}

@end
