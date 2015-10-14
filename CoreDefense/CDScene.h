//
//  CDScene.h
//  CoreDefense
//
//  Created by Connor Brewster on 10/8/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import "CDNode.h"

@interface CDScene : CDNode

- (void)renderWithEncoder:(id <MTLRenderCommandEncoder>)encoder;

- (void)updateScene;

@end
