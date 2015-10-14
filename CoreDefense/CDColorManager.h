//
//  CDColorManager.h
//  CoreDefense
//
//  Created by Connor Brewster on 10/10/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CDColorized

- (void)setNewColor:(UIColor*)color;

@end

@interface CDColorManager : NSObject
@property (nonatomic, strong) UIColor *currentColor;

- (instancetype)init;
- (void)newColor;
- (void)addColorizedObject:(id <CDColorized>)colorized;
- (void)removeColorizedObject:(id <CDColorized>)colorized;
@end
