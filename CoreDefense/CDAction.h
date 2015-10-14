//
//  CDAction.h
//  CoreDefense
//
//  Created by Connor Brewster on 10/13/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDNode.h"

@interface CDAction : NSObject {
    float _duration, _timeLeft;
}
@property (nonatomic, weak) CDNode *node;

- (instancetype)initWithDuration:(float)duration;

- (void)update:(float)dt;

- (void)processAction:(float)dt;

- (float)getProgress;

@end
