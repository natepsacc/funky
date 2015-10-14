//
//  CDPipelineManager.m
//  CoreDefense
//
//  Created by Connor Brewster on 10/8/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import "CDPipelineManager.h"

@implementation CDPipelineManager {
    NSMutableDictionary<NSString*,id <MTLRenderPipelineState>> *_pipelineStates;
    id <MTLDevice> _device;
    id <MTLLibrary> _library;
    MTKView *_metalView;
}

- (instancetype)initWithDevice:(id <MTLDevice>)device
                 shaderLibrary:(id <MTLLibrary>)library
                     metalView:(MTKView *)view {
    if (self = [super init]) {
        _metalView = view;
        _device = device;
        _library = library;
        _pipelineStates = [NSMutableDictionary dictionary];
        [self setupPipelineStates];
    }
    return self;
}

- (void)setupPipelineStates {
    [self addPipelineWithKey:@"passThrough" withVertexFunction:@"passThroughVertex" fragmentFunction:@"passThroughFragment"];
    [self addPipelineWithKey:@"white" withVertexFunction:@"passThroughVertex" fragmentFunction:@"whiteFragment"];
}

- (id <MTLRenderPipelineState>)getPipelineStateWithKey:(NSString*)key {
    return [_pipelineStates objectForKey:key];
}

- (void)addPipelineWithKey:(NSString*)key
        withVertexFunction:(NSString*)vertex
          fragmentFunction:(NSString*)fragment {
    id <MTLFunction> vertexFunction = [_library newFunctionWithName:vertex];
    
    if(!vertexFunction)
        NSLog(@">> ERROR: Couldn't load vertex function from default library");
    
    id <MTLFunction> fragmentFunction = [_library newFunctionWithName:fragment];
    
    if(!fragmentFunction)
        NSLog(@">> ERROR: Couldn't load fragment function from default library");
    
    //  create a pipeline state for the quad
    MTLRenderPipelineDescriptor *pipelineDescriptor = [MTLRenderPipelineDescriptor new];
    
    if(!pipelineDescriptor)
    {
        NSLog(@">> ERROR: Failed creating a pipeline state descriptor!");
    } // if
    
    pipelineDescriptor.colorAttachments[0].pixelFormat = _metalView.colorPixelFormat;
    pipelineDescriptor.colorAttachments[0].blendingEnabled = YES;
    pipelineDescriptor.colorAttachments[0].rgbBlendOperation = MTLBlendOperationAdd;
    pipelineDescriptor.colorAttachments[0].alphaBlendOperation = MTLBlendOperationAdd;
    pipelineDescriptor.colorAttachments[0].sourceRGBBlendFactor = MTLBlendFactorSourceAlpha;
    pipelineDescriptor.colorAttachments[0].sourceAlphaBlendFactor = MTLBlendFactorSourceAlpha;
    pipelineDescriptor.colorAttachments[0].destinationRGBBlendFactor = MTLBlendFactorOneMinusSourceAlpha;
    pipelineDescriptor.colorAttachments[0].destinationAlphaBlendFactor = MTLBlendFactorOneMinusSourceAlpha;
    
    pipelineDescriptor.depthAttachmentPixelFormat = _metalView.depthStencilPixelFormat;
    pipelineDescriptor.stencilAttachmentPixelFormat = _metalView.depthStencilPixelFormat;
    pipelineDescriptor.sampleCount      = _metalView.sampleCount;
    pipelineDescriptor.vertexFunction   = vertexFunction;
    pipelineDescriptor.fragmentFunction = fragmentFunction;
    
    
    NSError *pError = nil;
    id <MTLRenderPipelineState> pipelineState = [_device newRenderPipelineStateWithDescriptor:pipelineDescriptor
                                                                                             error:&pError];
    if(!pipelineState)
    {
        NSLog(@">> ERROR: Failed acquiring pipeline state descriptor: %@", pError);
    }
    
    [_pipelineStates setObject:pipelineState forKey:key];
}


@end
