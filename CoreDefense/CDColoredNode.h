//
//  CDColoredNode.h
//  CoreDefense
//
//  Created by Connor Brewster on 10/10/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import "CDNode.h"
#import "CDColorManager.h"

@interface CDColoredNode : CDNode <CDColorized> {
    float offsetHue, offsetBrightness;
    float transitionTime;
    float currentTime;
}
@property (nonatomic, strong) UIColor *desiredColor;

- (instancetype)init;


@end
