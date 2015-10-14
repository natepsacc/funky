//
//  CDColorUtility.h
//  CoreDefense
//
//  Created by Connor Brewster on 10/12/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#ifndef CDColorUtility_h
#define CDColorUtility_h

#import <UIKit/UIKit.h>

static UIColor* getComplementary(UIColor *color) {
    CGFloat hue, brightness, saturation;
    [color getHue:&hue saturation:&saturation brightness:&brightness alpha:nil];
    hue += 0.5;
    hue = fmod(hue, 1.0f);
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.0f];
}

static UIColor* getTriad(UIColor *color) {
    CGFloat hue, brightness, saturation;
    [color getHue:&hue saturation:&saturation brightness:&brightness alpha:nil];
    hue += 1.0f / 3.0f;
    hue = fmod(hue, 1.0f);
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.0f];
}

#endif /* CDColorUtility_h */
