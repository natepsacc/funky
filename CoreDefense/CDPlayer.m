//
//  CDPlayer.m
//  CoreDefense
//
//  Created by Connor Brewster on 10/11/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import "CDPlayer.h"
#import "CDCircle.h"

@implementation CDPlayer {
    UIColor *_currentColor;
    CDCircle *_outline;
    CDCircle *_center;
}

- (instancetype)initWithColor:(UIColor*)color {
    if (self = [super init]) {
        _currentColor = color;
        
        _outline = [[CDCircle alloc] initWithColor:getComplementary(color) withBrightnessOffset: 0.3f];
        _outline.frame = CGRectMake(0.0f, 0.0f, 42.0f, 42.0f);
        
        _center = [[CDCircle alloc] initWithColor:getComplementary(color) withBrightnessOffset: -0.3f];
        _center.frame = CGRectMake(0.0f, 0.0f, 38.0f, 38.0f);
        
        _radius = 21.0f;
        
        [self addChild:_outline];
        [self addChild:_center];
    }
    return self;
}

- (void)setNewColor:(UIColor *)color {
    _currentColor = getComplementary(color);
    [_center setNewColor:getComplementary(color)];
    [_outline setNewColor:getComplementary(color)];
}

@end
