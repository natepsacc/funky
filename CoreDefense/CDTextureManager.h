//
//  CDTextureManager.h
//  CoreDefense
//
//  Created by Connor Brewster on 10/8/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>

#import "CDTexture.h"

@interface CDTextureManager : NSObject
@property (nonatomic, strong) NSMutableDictionary<NSString*, CDTexture*> *textures;

- (id)initWidthDevice:(id <MTLDevice>)device;

- (CDTexture*)getTextureFromName:(NSString*)name;

@end
