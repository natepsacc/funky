//
//  CDPipelineManager.h
//  CoreDefense
//
//  Created by Connor Brewster on 10/8/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>

@interface CDPipelineManager : NSObject

- (instancetype)initWithDevice:(id <MTLDevice>)device
                 shaderLibrary:(id <MTLLibrary>)library
                     metalView:(MTKView*)view;

- (id <MTLRenderPipelineState>)getPipelineStateWithKey:(NSString*)key;

- (void)addPipelineWithKey:(NSString*)key
        withVertexFunction:(NSString*)vertex
          fragmentFunction:(NSString*)fragment;
@end
