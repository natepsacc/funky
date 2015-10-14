//
//  CDGameLogic.h
//  CoreDefense
//
//  Created by Connor Brewster on 10/12/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDCenter.h"
#import "CDEnemySpawner.h"

@interface CDGameLogic : NSObject

- (instancetype)initWithCenter:(CDCenter*)center
                  enemySpawner:(CDEnemySpawner*)enemySpawner;

- (void)update:(float)dt;

@end
