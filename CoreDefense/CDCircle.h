//
//  CDBackgroundCircle.h
//  CoreDefense
//
//  Created by Connor Brewster on 10/10/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import "CDGraphics.h"
#import "CDColoredNode.h"

@interface CDCircle : CDColoredNode
@property (nonatomic, strong) CDSprite *cirlceSprite;
@property (nonatomic) CGRect frame;

- (instancetype)initWithColor:(UIColor*)color;
- (instancetype)initWithColor:(UIColor*)color withOffsets:(BOOL)offsets;
- (instancetype)initWithColor:(UIColor*)color withBrightnessOffset:(float)offset;

@end
