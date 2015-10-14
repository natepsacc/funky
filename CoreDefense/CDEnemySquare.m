//
//  CDEnemySquare.m
//  CoreDefense
//
//  Created by Connor Brewster on 10/12/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import "CDEnemySquare.h"

@implementation CDEnemySquare {
    CDSprite *_square;
    float _speed;
}

- (instancetype)init {
    if (self = [super init]) {
        _square = [[CDSprite alloc] initWithImageNamed:@"Square"];
        _square.frame = CGRectMake(0.0f, 0.0f, 38.0f, 38.0f);
        [self addChild:_square];
        
        _speed = 200.0f;
        self.radius = 19.0f;
    }
    return self;
}

- (void)update:(float)dt {
    _square.rotation += 8.0f * dt;
    self.position += vector_normalize(-self.position) * dt * _speed;
    
    [super update:dt];
}

@end
