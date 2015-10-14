//
//  CDNode.m
//  CoreDefense
//
//  Created by Connor Brewster on 10/8/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import "CDNode.h"
#import "MatrixUtility.h"
#import "CDAction.h"

@implementation CDNode

- (instancetype) init {
    if (self = [super init]) {
        _children = [NSMutableArray array];
        _childrenToRemove = [NSMutableArray array];
        _currentActions = [NSMutableArray array];
        _position = vector2(0.0f, 0.0f);
        _rotation = 0.0f;
        _scale = 1.0f;
        [self updateTranslation];
    }
    return self;
}

- (void) addChild:(CDNode *)node {
    // Only allow 1 parent per node
    if (node.parent != NULL) {
        [node removeFromParent];
    }
    node.parent = self;
    [self.children addObject:node];
    
}

- (void)addChildToBack:(CDNode*)node {
    // Only allow 1 parent per node
    if (node.parent != NULL) {
        [node removeFromParent];
    }
    node.parent = self;
    [self.children insertObject:node atIndex:0];
}

- (void)insertChild:(CDNode*)node atIndex:(NSInteger)index {
    // Only allow 1 parent per node
    if (node.parent != NULL) {
        [node removeFromParent];
    }
    node.parent = self;
    [self.children insertObject:node atIndex:index];
}

- (void) removeFromParent {
    if (self.parent != NULL) {
        // Children are removed at the end of the update each frame
        [self.parent.childrenToRemove addObject:self];
    }
}

- (void)drawWithEndcoder:(id<MTLRenderCommandEncoder>)encoder {
    for (CDNode *child in self.children) {
        [child drawWithEndcoder:encoder];
    }
}

- (void)update:(float)dt {
    if (_currentActions.count > 0) {
        [[_currentActions objectAtIndex:0] update:dt];
    }
    
    for (CDNode *child in self.children) {
        [child update:dt];
    }
    
    // END OF FRAME
    // Only child removing
    // Remove all children from that have been flagged for removal
    for (CDNode *child in self.childrenToRemove) {
        [self.children removeObject:child];
    }
    // Clear array for next update
    [self.childrenToRemove removeAllObjects];
}

- (void)updateTranslation {
    
    matrix_float4x4 model_matrix = matrix_multiply(matrix_from_translation(self.position.x, self.position.y, 0.0f), matrix_multiply(matrix_from_rotation(self.rotation, 0.0f, 0.0f, 1.0f), matrix_from_scale(self.scale)));
    
    _transforms = model_matrix;
}

- (matrix_float4x4)getTranslation {
    matrix_float4x4 parent_matrix = matrix_identity_float4x4;
    if (self.parent) {
        parent_matrix = [self.parent getTranslation];
    }
    return matrix_multiply(parent_matrix, _transforms);
}

- (void)setPosition:(vector_float2)position {
    _position = position;
    [self updateTranslation];
}

- (void)setScale:(float)scale {
    _scale = scale;
    [self updateTranslation];
}

- (void)setRotation:(float)rotation {
    _rotation = rotation;
    [self updateTranslation];
}

- (void)runAction:(CDAction*)action {
    action.node = self;
    [_currentActions addObject:action];
}

- (void)removeAllActions {
    [_currentActions removeAllObjects];
}

- (void)removeAction:(CDAction*)action {
    action.node = NULL;
    [_currentActions removeObject:action];
}

- (void)touchMovedAtLocation:(vector_float2)location {
    
}

- (void)touchBeganAtLocation:(vector_float2)location {
    
}


@end
