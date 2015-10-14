//
//  CDCenter.m
//  CoreDefense
//
//  Created by Connor Brewster on 10/10/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import "CDCenter.h"
#import "CDActionMove.h"
#import "CDActionScale.h"

const float kPlayerSpeed = 2.0f;

@implementation CDCenter {
    float _time;
    CDNode *_coreLayer;
    vector_float2 _playerDesiredLocation;
    NSMutableArray<CDCore*> *_coresToRemove;
}

- (instancetype)initWithColor:(UIColor*)color {
    if (self = [super init]) {
        _currentColor = color;
        _outline = [[CDSprite alloc] initWithImageNamed:@"Circle"];
        _outline.color = [UIColor whiteColor];
        _outline.colorizeFactor = 1.0f;
        _outline.frame = CGRectMake(0.0f, 0.0f, 210.0f, 210.0f);
        
        _center = [[CDCircle alloc] initWithColor:color withBrightnessOffset:-0.2f];
        _center.frame = CGRectMake(0.0f, 0.0f, 205.0f, 205.0f);
        
        _coreLayer = [[CDNode alloc] init];
        
        _player = [[CDPlayer alloc] initWithColor:color];
        _playerDesiredLocation = vector2(0.0f, 0.0f);
        
        _time = 0.0f;
        
        [self addChild:_outline];
        [self addChild:_center];
        [self addChild:_coreLayer];
        [self addChild:_player];
        
        [self setupCores];
    }
    return self;
}

- (void)setupCores {
    _cores = [NSMutableArray array];
    _coresToRemove = [NSMutableArray array];
    for (int i = 0; i < 6; ++i) {
        CDCore *core = [[CDCore alloc] initWithColor:_currentColor];
        core.position = 45.0f * vector2(cosf(i * (M_PI * 2.0f / 6.0f)), sinf(i * (M_PI * 2.0f / 6.0f)));
        [_coreLayer addChild:core];
        [_cores addObject:core];
    }
}

- (void)recalculateCorePositions {
    for (int i = 0; i < _cores.count; ++i) {
        CDCore *core = [_cores objectAtIndex:i];
        [core removeAllActions];
        vector_float2 destination;
        if (_cores.count == 1) {
            destination = vector2(0.0f, 0.0f);
            [core runAction:[[CDActionScale alloc] initWithDuration:0.1f toScale:1.2f]];
        } else {
            destination = (33.0f + (2.0f * _cores.count)) * vector2(cosf((M_PI * 2.0f) * i / _cores.count), sinf((M_PI * 2.0f) * i / _cores.count));
        }
        [core runAction:[[CDActionMove alloc] initWithDuration:0.1f toLocation:destination]];
    }
}

- (void)removeCore:(CDCore*)core {
    [core removeFromParent];
    [_coresToRemove addObject:core];
}

- (void)update:(float)dt {
    _coreLayer.rotation += M_PI / 1.5f * dt;
    _time += dt * 5.0f;
    _outline.scale = 1.02f + (sinf(_time)*0.01f);
    [self updatePlayer:dt];
    
    BOOL removedCores = false;
    for (CDCore* core in _coresToRemove) {
        [_cores removeObject:core];
        removedCores = true;
    }
    [_coresToRemove removeAllObjects];

    if (removedCores) {
        [self recalculateCorePositions];
    }
    
    [super update:dt];
}

- (void)updatePlayer:(float)dt {
    if (vector_distance(_player.position, _playerDesiredLocation) < 0.5f) {
        _player.position = _playerDesiredLocation;
        return;
    }
    vector_float2 vector = _playerDesiredLocation - _player.position;
//    vector = vector_normalize(vector);
    _player.position += vector * kPlayerSpeed * dt;
    if (vector_distance(_player.position, vector2(0.0f, 0.0f)) > 81.0f) {
        _player.position = 81.0f * vector_normalize(_player.position);
    }
}

- (void)setNewColor:(UIColor *)color {
    [_center setNewColor:color];
    [_player setNewColor:color];
    for (CDCore *core in _cores) {
        [core setNewColor:color];
    }
}

- (void)touchBeganAtLocation:(vector_float2)location {
    vector_float2 locationInNode = [[CDMetalManager sharedManager] locationOfPoint:location inNode:self];
    _playerDesiredLocation = locationInNode;
}

- (void)touchMovedAtLocation:(vector_float2)location {
    vector_float2 locationInNode = [[CDMetalManager sharedManager] locationOfPoint:location inNode:self];
    _playerDesiredLocation = locationInNode;
}

@end
