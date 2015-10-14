//
//  CDBackground.m
//  CoreDefense
//
//  Created by Connor Brewster on 10/9/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#define ARC4RANDOM_MAX      0x100000000

#import "CDBackground.h"
#import "CDCircle.h"
#import "MatrixUtility.h"

@implementation CDBackground {
    float _spawnRate, _timeSinceLastSpawn;
    UIColor *_currenColor;
}

- (instancetype)initWithColor:(UIColor *)color {
    if (self = [super init]) {
        _spawnRate = 0.3f;
        _timeSinceLastSpawn = 0.0f;
        _currenColor = color;
        [self loadCircles];
    }
    return self;
}

- (void)loadCircles {
    CDCircle *circle = [[CDCircle alloc] initWithColor:_currenColor];
    circle.scale = 3.0f;
    [self addChild:circle];
}

- (void)addCircle {
    CDCircle *circle = [[CDCircle alloc] initWithColor:_currenColor];
    circle.scale = 3.0f;
    [self addChildToBack:circle];
}

- (void)update:(float)dt {
    _timeSinceLastSpawn += dt;
    
    
    if (_timeSinceLastSpawn > _spawnRate) {
        _timeSinceLastSpawn -= _spawnRate;
        [self addCircle];
    }

    for (CDSprite* circle in self.children) {
        circle.scale -= 0.66f * dt;
        if (circle.scale <= 0) {
            [circle removeFromParent];
        }
    }
    
    [super update:dt];
}

- (void)setNewColor:(UIColor *)color {
    _currenColor = color;
    for (CDCircle* circle in self.children) {
        [circle setNewColor:color];
    }
}

@end
