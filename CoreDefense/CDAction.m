//
//  CDAction.m
//  CoreDefense
//
//  Created by Connor Brewster on 10/13/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import "CDAction.h"

@implementation CDAction

- (instancetype)initWithDuration:(float)duration {
    if (self = [super init]) {
        _duration = duration;
        _timeLeft = duration;
    }
    return self;
}

- (void)update:(float)dt {
    if (!self.node) {
        return;
    }
    
    [self processAction:dt];
    
    _timeLeft -= dt;
    if (_timeLeft <= 0.0f) {
        [_node removeAction:self];
    }
}

- (void)processAction:(float)dt {
    
}

- (float)getProgress {
    return (_duration - _timeLeft) / _duration;
}

@end
