//
//  CDNode.h
//  CoreDefense
//
//  Created by Connor Brewster on 10/8/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>
#import <simd/simd.h>
#import "CDSharedStructures.h"

@class CDAction;

@interface CDNode : NSObject
@property (nonatomic, strong) NSMutableArray<CDNode*> *childrenToRemove;
@property (nonatomic, strong) NSMutableArray<CDNode*> *children;
@property (nonatomic, strong) NSMutableArray<CDAction*> *currentActions;
@property (nonatomic, weak) CDNode* parent;
@property (nonatomic) vector_float2 position;
@property (nonatomic) float rotation;
@property (nonatomic) float scale;
@property matrix_float4x4 transforms;


- (instancetype) init;

- (void)addChild:(CDNode*)node;

- (void)addChildToBack:(CDNode*)node;

- (void)insertChild:(CDNode*)node atIndex:(NSInteger)index;

- (void)removeFromParent;

- (void)drawWithEndcoder:(id <MTLRenderCommandEncoder>)encoder;

- (void)update:(float)dt;

- (matrix_float4x4)getTranslation;

- (void)touchMovedAtLocation:(vector_float2)location;

- (void)touchBeganAtLocation:(vector_float2)location;

- (void)runAction:(CDAction*)action;

- (void)removeAction:(CDAction*)action;

- (void)removeAllActions;

@end
