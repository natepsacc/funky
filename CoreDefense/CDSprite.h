//
//  CDSprite.h
//  CoreDefense
//
//  Created by Connor Brewster on 10/8/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import "CDNode.h"
#import "CDTexture.h"

@interface CDSprite : CDNode
@property (nonatomic, strong) CDTexture* texture;
@property (nonatomic) CGRect frame;
@property (nonatomic, strong) UIColor *color;
@property float colorizeFactor;
@property (nonatomic, strong) id <MTLRenderPipelineState> pipelineState;


- (id)initWithImageNamed:(NSString*)name;

- (void)update:(float)dt;

- (void)drawWithEndcoder:(id <MTLRenderCommandEncoder>)encoder;

@end
