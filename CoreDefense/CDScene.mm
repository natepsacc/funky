//
//  CDScene.m
//  CoreDefense
//
//  Created by Connor Brewster on 10/8/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import "CDScene.h"

@implementation CDScene {
    NSTimeInterval lastTime;
}

- (void)renderWithEncoder:(id<MTLRenderCommandEncoder>)encoder {
    for (CDNode* child in self.children) {
        [child drawWithEndcoder:encoder];
    }
}

- (void)updateScene {
    NSTimeInterval currentTime = CACurrentMediaTime();
    if (!lastTime) {
        lastTime = currentTime;
    }
    
    NSTimeInterval dt = currentTime - lastTime;
    
    lastTime = currentTime;
    
    dt = fmin(dt, 1.0f/60.0f); 
    
    [self update:dt];
    
    for (CDNode* child in self.children) {
        [child update:dt];
    }
}

@end
