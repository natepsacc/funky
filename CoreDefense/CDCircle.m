//
//  CDBackgroundCircle.m
//  CoreDefense
//
//  Created by Connor Brewster on 10/10/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import "CDCircle.h"

@implementation CDCircle

- (instancetype)initWithColor:(UIColor *)color {
    if (self = [super init]) {
        _cirlceSprite = [[CDSprite alloc] initWithImageNamed:@"Circle"];
        _cirlceSprite.colorizeFactor = 1.0f;
        
        CGFloat maxBrightnessOffset = 0.2f;
        offsetBrightness = ((float)arc4random() / UINT32_MAX) * maxBrightnessOffset * 2.0;
        offsetBrightness -= maxBrightnessOffset;
        offsetHue = 0.0f;
        
        _cirlceSprite.color = [self getColorFromOffsets:color];

        [self addChild:_cirlceSprite];
    }
    return self;
}

- (instancetype)initWithColor:(UIColor *)color withOffsets:(BOOL)offsets {
    if (self = [super init]) {
        if (offsets) {
            return [self initWithColor:color];
        } else {
            _cirlceSprite = [[CDSprite alloc] initWithImageNamed:@"Circle"];
            _cirlceSprite.colorizeFactor = 1.0f;
            offsetBrightness = 0.0f;
            offsetHue = 0.0f;
            
            _cirlceSprite.color = color;
            
            [self addChild:_cirlceSprite];
        }
    }
    return self;
}

- (instancetype)initWithColor:(UIColor*)color withBrightnessOffset:(float)offset {
    if (self = [super init]) {
        _cirlceSprite = [[CDSprite alloc] initWithImageNamed:@"Circle"];
        _cirlceSprite.colorizeFactor = 1.0f;
        offsetBrightness = offset;
        offset = fmodf(offset, 1.0);
        offsetHue = 0.0f;
        
        _cirlceSprite.color = [self getColorFromOffsets:color];
        
        [self addChild:_cirlceSprite];
    }
    return self;
}

- (UIColor*)getColorFromOffsets:(UIColor*)color {
    CGFloat hue, saturation, brightness;
    [color getHue:&hue saturation:&saturation brightness:&brightness alpha:nil];
    
    brightness += offsetBrightness;
    hue += offsetHue;
    hue = hue > 1.0 ? hue - 1.0 : hue;
    hue = hue < 0.0 ? hue + 1.0 : hue;
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.0];
}

- (void) setNewColor:(UIColor *)color {
    CGFloat hue, saturation, brightness;
    [color getHue:&hue saturation:&saturation brightness:&brightness alpha:nil];
    
    brightness += offsetBrightness;
    hue += offsetHue;
    hue = hue > 1.0 ? hue - 1.0 : hue;
    hue = hue < 0.0 ? hue + 1.0 : hue;
    
    self.desiredColor = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.0];
    
    currentTime = 0.0f;
}

- (void)update:(float)dt {
    if (currentTime < transitionTime) {
        currentTime += dt;
        [self updateColor:dt];
    }
    
    [super update:dt];
}

- (void)updateColor:(float)dt {
    CGFloat red, green, blue;
    [_cirlceSprite.color getRed:&red green:&green blue:&blue alpha:nil];
    
    CGFloat finalRed, finalGreen, finalBlue;
    [self.desiredColor getRed:&finalRed green:&finalGreen blue:&finalBlue alpha:nil];
    
    float progress = currentTime / transitionTime;
    progress = fminf(1.0, progress);
    
    CGFloat newRed   = (1.0 - progress) * red   + progress * finalRed;
    CGFloat newGreen = (1.0 - progress) * green + progress * finalGreen;
    CGFloat newBlue  = (1.0 - progress) * blue  + progress * finalBlue;
    _cirlceSprite.color = [UIColor colorWithRed:newRed green:newGreen blue:newBlue alpha:1.0];

}

- (void) setFrame:(CGRect)frame {
    _frame = frame;
    [_cirlceSprite setFrame:_frame];
}

@end
