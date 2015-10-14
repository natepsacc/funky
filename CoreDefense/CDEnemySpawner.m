//
//  CDEnemySpawner.m
//  CoreDefense
//
//  Created by Connor Brewster on 10/12/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import "CDEnemySpawner.h"
#import "CDEnemy.h"
#import "CDEnemySquare.h"
#import "CDEnemyTriangle.h"

@implementation CDEnemySpawner {
    float _spawnRate;
    float _timeSinceLastSpawn;
}

- (instancetype)init {
    if (self = [super init]) {
        _spawnRate = 1.0f;
        _timeSinceLastSpawn = 0.0f;
    }
    return self;
}

- (void)update:(float)dt {
    _timeSinceLastSpawn += dt;
    if (_timeSinceLastSpawn >= _spawnRate) {
        _timeSinceLastSpawn -= _spawnRate;
        [self spawnEnemy];
    }
    
    [super update:dt];
}

- (void)spawnEnemy {
    float randomAngle = ((float)arc4random() / UINT32_MAX) * 2.0f * M_PI;
    CDEnemyTriangle *enemy = [[CDEnemyTriangle alloc] init];
    enemy.position = vector2(cosf(randomAngle), sinf(randomAngle)) * 700.0f;
    [self addChild:enemy];
}

@end
