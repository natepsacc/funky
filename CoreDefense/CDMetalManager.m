//
//  CDMetalManager.m
//  CoreDefense
//
//  Created by Connor Brewster on 10/8/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import <simd/simd.h>
#import "CDMetalManager.h"
#import "MatrixUtility.h"

// static const size_t kMaxBytesPerFrame = 1024*1024;

@implementation CDMetalManager

+ (id)sharedManager {
    static CDMetalManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (instancetype) init {
    if (self = [super init]) {
        // initialize properties
        _paused = NO;
        _constantDataBufferIndex = 0;
        _inflightSemaphore = dispatch_semaphore_create(kMaxInflightBuffers);
        _device = MTLCreateSystemDefaultDevice();
        _textureManager = [[CDTextureManager alloc] initWidthDevice:_device];
        _commandQueue = [_device newCommandQueue];
        _shaderLibrary = [_device newDefaultLibrary];
    }
    return self;
}

- (void)setMetalView:(MTKView *)metalView {
    _metalView = metalView;
    _pipelineManager = [[CDPipelineManager alloc] initWithDevice:_device shaderLibrary:_shaderLibrary metalView:_metalView];
    [self reshape];
}

- (void)reshape {
    float width = _metalView.frame.size.width;
    float height = _metalView.frame.size.height;
    _orthograph = matrix_from_orthographic(-width / 2.0f, width / 2.0f, - height / 2.0f, height / 2.0f, -10.0f, 10.0f);
}

- (void)render {
    if (_paused) {
        return;
    }
    
    [_currentScene updateScene];
    
    dispatch_semaphore_wait(_inflightSemaphore, DISPATCH_TIME_FOREVER);
    
    id <MTLCommandBuffer> commandBuffer = [_commandQueue commandBuffer];
    MTLRenderPassDescriptor *renderPassDescriptor = _metalView.currentRenderPassDescriptor;
    
    if (!renderPassDescriptor) {
        return;
    }
    
    renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColorMake(0.0, 0.0, 0.0, 1.0);
    renderPassDescriptor.colorAttachments[0].storeAction = MTLStoreActionStore;
    renderPassDescriptor.colorAttachments[0].loadAction = MTLLoadActionClear;
    
    commandBuffer.label = @"Frame";
    
    __block dispatch_semaphore_t block_sema = _inflightSemaphore;
    [commandBuffer addCompletedHandler:^(id<MTLCommandBuffer> buffer) {
        dispatch_semaphore_signal(block_sema);
    }];
    
    id <MTLRenderCommandEncoder> encoder = [commandBuffer renderCommandEncoderWithDescriptor:renderPassDescriptor];
    encoder.label = @"SpriteRenderEncoder";
    
    // Render the current scene
    if (encoder != NULL) {
        [_currentScene renderWithEncoder:encoder];
    }
    
    [encoder endEncoding];
    
    id <CAMetalDrawable> drawable = [_metalView currentDrawable];

    if (drawable) {
        [commandBuffer presentDrawable:drawable];
    }
    
    _constantDataBufferIndex = (_constantDataBufferIndex + 1) % kMaxInflightBuffers;

    [commandBuffer commit];
}

- (void)drawInMTKView:(MTKView *)view {
    @autoreleasepool {
        [self render];
    }
}

- (void)mtkView:(MTKView *)view drawableSizeWillChange:(CGSize)size {
    [self reshape];
}

- (vector_float2)locationOfPoint:(CGPoint)point {
    return vector2((float)(point.x - _metalView.frame.size.width / 2.0f), -(float)(point.y - _metalView.frame.size.height / 2.0f));
}

- (vector_float2)locationOfPoint:(vector_float2)point inNode:(CDNode*)node {
    vector_float4 point4 = vector4(point.x, point.y, 0.0f, 1.0f);
    return matrix_multiply(matrix_invert([node getTranslation]), point4).xy;
}

- (vector_float2)locationOfPoint:(vector_float2)point fromNode:(CDNode*)fromNode toNode:(CDNode*)toNode {
    vector_float4 point4 = vector4(point.x, point.y, 0.0f, 1.0f);
    vector_float4 untranslated = matrix_multiply(matrix_invert([toNode getTranslation]), point4);
    return matrix_multiply([fromNode getTranslation], untranslated).xy;
}

@end
