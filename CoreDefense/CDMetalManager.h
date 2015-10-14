//
//  CDMetalManager.h
//  CoreDefense
//
//  Created by Connor Brewster on 10/8/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>

#import "CDTextureManager.h"
#import "CDPipelineManager.h"
#import "CDScene.h"

static const uint32_t kMaxInflightBuffers = 3;

@interface CDMetalManager : NSObject <MTKViewDelegate>

@property(nonatomic, weak) MTKView *metalView;
@property(nonatomic, strong) id <MTLDevice> device;
@property(nonatomic, strong) id <MTLLibrary> shaderLibrary;
@property(nonatomic, strong) id <MTLCommandQueue> commandQueue;
@property(nonatomic, strong) CDTextureManager *textureManager;
@property(nonatomic, strong) CDPipelineManager *pipelineManager;
@property(nonatomic, strong) CDScene *currentScene;
@property dispatch_semaphore_t inflightSemaphore;
@property NSUInteger constantDataBufferIndex;
@property matrix_float4x4 orthograph;
@property BOOL paused;

- (instancetype) init;

+ (id)sharedManager;

- (void)render;

- (void)reshape;

- (vector_float2)locationOfPoint:(CGPoint)point;

- (vector_float2)locationOfPoint:(vector_float2)point inNode:(CDNode*)node;

- (vector_float2)locationOfPoint:(vector_float2)point fromNode:(CDNode*)fromNode toNode:(CDNode*)toNode;

@end
