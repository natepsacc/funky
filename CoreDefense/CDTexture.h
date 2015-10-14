//
//  CDTexture.h
//  CoreDefense
//
//  Created by Connor Brewster on 10/9/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Metal/Metal.h>

@interface CDTexture : NSObject
@property (nonatomic, readonly)  id <MTLTexture>  metalTexture;
@property (nonatomic, readonly)  MTLTextureType   target;
@property (nonatomic, readonly)  uint32_t         width;
@property (nonatomic, readonly)  uint32_t         height;
@property (nonatomic, readonly)  uint32_t         widthPoints;
@property (nonatomic, readonly)  uint32_t         heightPoints;
@property (nonatomic, readonly)  uint32_t         depth;
@property (nonatomic, readonly)  uint32_t         format;
@property (nonatomic, readonly)  NSString        *image;
@property (nonatomic, readwrite) BOOL             flip;


- (instancetype) initWithImageNamed:(NSString*) imageName;

- (BOOL) finalize:(id<MTLDevice>)device;

@end
