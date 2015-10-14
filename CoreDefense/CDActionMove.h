//
//  CDActionMove.h
//  CoreDefense
//
//  Created by Connor Brewster on 10/13/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import "CDAction.h"

@interface CDActionMove : CDAction

- (instancetype)initWithDuration:(float)duration toLocation:(vector_float2)destination;

@end
