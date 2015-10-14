//
//  CDPlayer.h
//  CoreDefense
//
//  Created by Connor Brewster on 10/11/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import "CDGraphics.h"
#import "CDColorManager.h"
#import "CDColorUtility.h"

@interface CDPlayer : CDNode <CDColorized>
@property float radius;

- (instancetype)initWithColor:(UIColor*)color;

@end
