//
//  CDColoredNode.m
//  CoreDefense
//
//  Created by Connor Brewster on 10/10/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import "CDColoredNode.h"

@implementation CDColoredNode

- (instancetype)init {
    if (self = [super init]) {
        transitionTime = 5.0f;
        currentTime = transitionTime;
    }
    return self;
}

- (void)setNewColor:(UIColor *)color {
    
}

@end
