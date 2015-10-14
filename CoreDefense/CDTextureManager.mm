//
//  CDTextureManager.m
//  CoreDefense
//
//  Created by Connor Brewster on 10/8/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import "CDTextureManager.h"
#import <UIKit/UIKit.h>

@implementation CDTextureManager {
    id <MTLDevice> _device;
}

- (id)initWidthDevice:(id <MTLDevice>)device {
    if (self = [super init]) {
        _textures = [NSMutableDictionary dictionary];
        _device = device;
    }
    return self;
}

- (CDTexture*)getTextureFromName:(NSString*)name{
    if ([self.textures objectForKey:name]) {
        return [self.textures objectForKey:name];
    }
    CDTexture *texture = [[CDTexture alloc] initWithImageNamed:name];
    [texture finalize:_device];
    [self.textures setObject:texture forKey:name];
    return texture;
}


@end
