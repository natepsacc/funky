//
//  CDColorManager.m
//  CoreDefense
//
//  Created by Connor Brewster on 10/10/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import "CDColorManager.h"

@implementation CDColorManager {
    NSMutableArray<id <CDColorized>> *_colorizedObjects;
}

- (instancetype)init {
    if (self = [super init]) {
        _colorizedObjects = [NSMutableArray array];
        [self newColor];
    }
    return self;
}

- (void)addColorizedObject:(id <CDColorized>)colorized {
    [_colorizedObjects addObject:colorized];
}

- (void)removeColorizedObject:(id <CDColorized>)colorized {
    [_colorizedObjects removeObject:colorized];
}

- (void)newColor {
    _currentColor = [UIColor colorWithHue:(float)arc4random() / UINT32_MAX saturation:0.85 brightness:0.75 alpha:1.0];
    for (id <CDColorized> colorized in _colorizedObjects) {
        [colorized setNewColor:_currentColor];
    }
}

@end
