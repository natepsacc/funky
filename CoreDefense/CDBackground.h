//
//  CDBackground.h
//  CoreDefense
//
//  Created by Connor Brewster on 10/9/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import "CDGraphics.h"
#import "CDColorManager.h"

@interface CDBackground : CDNode <CDColorized>

- (instancetype)initWithColor:(UIColor*)color;

@end
