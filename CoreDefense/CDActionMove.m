//
//  CDActionMove.m
//  CoreDefense
//
//  Created by Connor Brewster on 10/13/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import "CDActionMove.h"

@implementation CDActionMove {
    vector_float2 _startLocation;
    vector_float2 _destinationLocation;
}

- (instancetype)initWithDuration:(float)duration toLocation:(vector_float2)destination {
    if (self = [super initWithDuration:duration]) {
        _destinationLocation = destination;
    }
    return self;
}

- (void)setNode:(CDNode *)node {
    [super setNode:node];
    _startLocation = node.position;
}

- (void)processAction:(float)dt {
    float progress = [self getProgress];
    self.node.position = (1.0 - progress) * _startLocation + progress * _destinationLocation;
}

@end
