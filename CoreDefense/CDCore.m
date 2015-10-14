//
//  CDCore.m
//  CoreDefense
//
//  Created by Connor Brewster on 10/10/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import "CDCore.h"
#import "CDCircle.h"
#import "CDColorUtility.h"

@implementation CDCore {
    UIColor *_currentColor;
    CDSprite *_outline;
    CDCircle *_center;
}

- (instancetype)initWithColor:(UIColor*)color {
    if (self = [super init]) {
        _currentColor = color;
        
        _outline = [[CDSprite alloc] initWithImageNamed:@"Circle"];
        _outline.color = [UIColor whiteColor];
        _outline.colorizeFactor = 1.0f;
        _outline.frame = CGRectMake(0.0f, 0.0f, 40.0f, 40.0f);
        _center = [[CDCircle alloc] initWithColor:getTriad(color)];
        _center.frame = CGRectMake(0.0f, 0.0f, 36.0f, 36.0f);
        
        _radius = 20.0f;
        
        [self addChild:_outline];
        [self addChild:_center];
    }
    return self;
}

- (void)setNewColor:(UIColor *)color {
    _currentColor = getTriad(color);
    [_center setNewColor:getTriad(color)];
}

@end
