//
//  CDCenter.h
//  CoreDefense
//
//  Created by Connor Brewster on 10/10/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import "CDGraphics.h"
#import "CDColorManager.h"
#import "CDCircle.h"
#import "CDPlayer.h"
#import "CDCore.h"

@interface CDCenter : CDNode <CDColorized>
@property (nonatomic, strong) CDSprite *outline;
@property (nonatomic, strong) CDCircle *center;
@property (nonatomic, strong) CDPlayer *player;
@property (nonatomic, strong) UIColor *currentColor;
@property (nonatomic, strong) NSMutableArray<CDCore*> *cores;

- (instancetype)initWithColor:(UIColor*)color;

- (void)recalculateCorePositions;

- (void)removeCore:(CDCore*)core;

@end
