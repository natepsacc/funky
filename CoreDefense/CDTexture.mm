//
//  CDTexture.m
//  CoreDefense
//
//  Created by Connor Brewster on 10/9/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import "CDTexture.h"
#import <UIKit/UIKit.h>

@implementation CDTexture

{
@private
    id <MTLTexture>  _metalTexture;
    MTLTextureType   _target;
    uint32_t         _width;
    uint32_t         _height;
    uint32_t         _widthPoints;
    uint32_t         _heightPoints;
    uint32_t         _depth;
    uint32_t         _format;
    BOOL             _flip;
    NSString        *_image;
}

- (instancetype) initWithImageNamed:(NSString*) imageName
{
    
    self = [super init];
    
    if(self)
    {
        _image         = imageName;
        _width         = 0;
        _height        = 0;
        _depth         = 1;
        _format        = MTLPixelFormatRGBA8Unorm;
        _target        = MTLTextureType2D;
        _metalTexture  = nil;
        _flip          = YES;
    } // if
    
    return self;
} // initWithResourceName

- (void) dealloc
{
    _image        = nil;
    _metalTexture = nil;
} // dealloc

- (void) setFlip:(BOOL)flip
{
    _flip = flip;
} // setFlip

// assumes png file
- (BOOL) finalize:(id <MTLDevice>)device
{
    if(_metalTexture)
    {
        return YES;
    } // if
    
    UIImage *pImage = [UIImage imageNamed:_image];
    
    if(!pImage)
    {
        return NO;
    } // if
    
    CGColorSpaceRef pColorSpace = CGColorSpaceCreateDeviceRGB();
    
    if(!pColorSpace)
    {
        return NO;
    } // if
    
    _width  = uint32_t(CGImageGetWidth(pImage.CGImage));
    _height = uint32_t(CGImageGetHeight(pImage.CGImage));
    _widthPoints = uint32_t(pImage.size.width);
    _heightPoints = uint32_t(pImage.size.height);
    
    uint32_t width    = _width;
    uint32_t height   = _height;
    uint32_t rowBytes = width * 4;
    
    CGContextRef pContext = CGBitmapContextCreate(NULL,
                                                  width,
                                                  height,
                                                  8,
                                                  rowBytes,
                                                  pColorSpace,
                                                  CGBitmapInfo(kCGImageAlphaPremultipliedLast));
    
    CGColorSpaceRelease(pColorSpace);
    
    if(!pContext)
    {
        return NO;
    } // if
    
    CGRect bounds = CGRectMake(0.0f, 0.0f, width, height);
    
    CGContextClearRect(pContext, bounds);
    
    // Vertical Reflect
    if(_flip)
    {
        CGContextTranslateCTM(pContext, width, height);
        CGContextScaleCTM(pContext, -1.0, -1.0);
    } // if
    
    CGContextDrawImage(pContext, bounds, pImage.CGImage);
    
    MTLTextureDescriptor *pTexDesc = [MTLTextureDescriptor texture2DDescriptorWithPixelFormat:MTLPixelFormatRGBA8Unorm
                                                                                        width:width
                                                                                       height:height
                                                                                    mipmapped:NO];
    if(!pTexDesc)
    {
        CGContextRelease(pContext);
        
        return NO;
    } // if
    
    _target       = pTexDesc.textureType;
    _metalTexture = [device newTextureWithDescriptor:pTexDesc];
    
    if(!_metalTexture)
    {
        CGContextRelease(pContext);
        
        return NO;
    } // if
    
    const void *pPixels = CGBitmapContextGetData(pContext);
    
    if(pPixels != NULL)
    {
        MTLRegion region = MTLRegionMake2D(0, 0, width, height);
        
        [_metalTexture replaceRegion:region
                         mipmapLevel:0
                           withBytes:pPixels
                         bytesPerRow:rowBytes];
    } // if
    
    CGContextRelease(pContext);
    
    return YES;
} // finalize


@end
