//
//  CDGameLogic.m
//  CoreDefense
//
//  Created by Connor Brewster on 10/12/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import "CDGameLogic.h"
#import "CDEnemy.h"

@implementation CDGameLogic {
    CDCenter *_center;
    CDEnemySpawner *_enemySpawner;
}

- (instancetype)initWithCenter:(CDCenter*)center
                  enemySpawner:(CDEnemySpawner*)enemySpawner {
    if (self = [super init]) {
        _center = center;
        _enemySpawner = enemySpawner;
    }
    return self;
}

- (void)update:(float)dt {
    for (CDEnemy *enemy in _enemySpawner.children) {
        if (vector_length(enemy.position) >= 150.0f) {
            continue;
        }
        if (vector_distance(enemy.position, _center.player.position) < enemy.radius + _center.player.radius) {
            [enemy removeFromParent];
        }
        for (CDCore *core in _center.cores) {
            vector_float2 coreLocation = [[CDMetalManager sharedManager] locationOfPoint:core.position fromNode:core.parent toNode:_center];
            if (vector_distance(enemy.position, coreLocation) < enemy.radius + core.radius) {
                [enemy removeFromParent];
                [_center removeCore:core];
            }
        }
    }
}

@end
