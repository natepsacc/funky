//
//  CDCore.h
//  CoreDefense
//
//  Created by Connor Brewster on 10/10/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import "CDGraphics.h"
#import "CDColoredNode.h"

@interface CDCore : CDNode <CDColorized>
@property float radius;

- (instancetype)initWithColor:(UIColor*)color;

@end
