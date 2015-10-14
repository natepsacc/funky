//
//  CDEnemyTriangle.m
//  CoreDefense
//
//  Created by Connor Brewster on 10/12/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import "CDEnemyTriangle.h"

@implementation CDEnemyTriangle {
    CDSprite *_triangle;
    float _speed;
}

- (instancetype)init {
    if (self = [super init]) {
        _triangle = [[CDSprite alloc] initWithImageNamed:@"Triangle"];
        _triangle.frame = CGRectMake(0.0f, 0.0f, 30.0f, 30.0f);
        [self addChild:_triangle];
        
        _speed = 200.0f;
        self.radius = 15.0f;
    }
    return self;
}

- (void)update:(float)dt {
    _triangle.rotation += 8.0f * dt;
    self.position += vector_normalize(-self.position) * dt * _speed;
    
    [super update:dt];
}


@end
