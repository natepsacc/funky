//
//  CDActionScale.m
//  CoreDefense
//
//  Created by Connor Brewster on 10/13/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import "CDActionScale.h"

@implementation CDActionScale {
    float _startScale;
    float _endScale;
}

- (instancetype)initWithDuration:(float)duration toScale:(float)scale {
    if (self = [super initWithDuration:duration]) {
        _endScale = scale;
    }
    return self;
}

- (void)setNode:(CDNode *)node {
    [super setNode:node];
    _startScale = node.scale;
}

- (void)processAction:(float)dt {
    float progress = [self getProgress];
    self.node.scale = (1.0 - progress) * _startScale + progress * _endScale;
}

@end
