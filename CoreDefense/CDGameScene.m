//
//  CDGameScene.m
//  CoreDefense
//
//  Created by Connor Brewster on 10/9/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import "CDGameScene.h"
#import "CDBackground.h"
#import "CDColorManager.h"
#import "CDEnemySpawner.h"
#import "CDCenter.h"
#import "MatrixUtility.h"
#import "CDGameLogic.h"

@implementation CDGameScene {
    CDNode *_backgroundLayer;
    CDNode *_centerLayer;
    CDNode *_enemiesLayer;
    CDCenter *_center;
    CDColorManager *_colorManager;
    CDGameLogic *_gameLogic;
    CDEnemySpawner *_enemySpawner;
    float _changeColorTime;
    float _timeSinceLastChange;
    float _time;
    float _rotationX;
    float _rotationY;
}

- (instancetype)init {
    if (self = [super init]) {        
        _colorManager = [[CDColorManager alloc] init];
        // Setup Layers
        _backgroundLayer = [[CDNode alloc] init];
        _centerLayer = [[CDNode alloc] init];
        _enemiesLayer = [[CDNode alloc] init];
        // Order is IMPORTANT!!!
        [self addChild:_backgroundLayer];
        [self addChild:_centerLayer];
        [self addChild:_enemiesLayer];
        
        [self setupBackground];
        [self setupCenter];
        [self setupEnemySpawner];
        [self setupGameLogic];
        
        _changeColorTime = 10.0f;
        _timeSinceLastChange = 0.0f;
        _time = 0.0f;
        self.scale = 0.45f;
    }
    return self;
}

- (void)setupCenter {
    _center = [[CDCenter alloc] initWithColor:_colorManager.currentColor];
    [_centerLayer addChild:_center];
    [_colorManager addColorizedObject:_center];
}

- (void)setupBackground {
    CDBackground *background = [[CDBackground alloc] initWithColor:_colorManager.currentColor];
    [_backgroundLayer addChild:background];
    [_colorManager addColorizedObject:background];
}

- (void)setupEnemySpawner {
    _enemySpawner = [[CDEnemySpawner alloc] init];
    [_enemiesLayer addChild:_enemySpawner];
}

- (void)setupGameLogic {
    _gameLogic = [[CDGameLogic alloc] initWithCenter:_center enemySpawner:_enemySpawner];
}

- (void)update:(float)dt {
    _time += dt * 2.0f;
    _rotationX += dt * 2.0f;
    _rotationY += dt * 2.0f;
    vector_float2 playerLocation = _center.player.position;

    self.position = vector2(playerLocation.x * 0.001f, playerLocation.y * 0.001f);
    
    _timeSinceLastChange += dt;
    if (_timeSinceLastChange >= _changeColorTime) {
        _timeSinceLastChange -= _changeColorTime;
        [_colorManager newColor];
    }
    
    [_gameLogic update:dt];
}

- (void)touchMovedAtLocation:(vector_float2)location {
    [_center touchMovedAtLocation:location];
}

- (void)touchBeganAtLocation:(vector_float2)location {
    [_center touchBeganAtLocation:location];
}

- (matrix_float4x4)getTranslation {
    vector_float2 playerLocation = _center.player.position;
//    matrix_float4x4 rotation = matrix_multiply(matrix_from_rotation(cosf(_rotationX) * 0.0008f, 0.0f, 1.0f, 0.0f),matrix_from_rotation(sinf(_rotationY) * 0.0008f, 1.0f, 0.0f, 0.0f));
    matrix_float4x4 rotation = matrix_multiply(matrix_from_rotation(-playerLocation.x * 0.00001f, 0.0f, 1.0f, 0.0f),matrix_from_rotation(playerLocation.y * 0.00001f, 1.0f, 0.0f, 0.0f));
//    matrix_float4x4 rotation = matrix_from_rotation(0.001f, 1.0f, 0.0f, 0.0f);
    return matrix_multiply(matrix_from_translation(0.0f, 0.0f, -0.5f), matrix_multiply(rotation, [super getTranslation]));
}

@end
