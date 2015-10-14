//
//  GameViewController.m
//  CoreDefense
//
//  Created by Connor Brewster on 10/8/15.
//  Copyright © 2015 Double Bit Studios. All rights reserved.
//

#import <simd/simd.h>
#import <ModelIO/ModelIO.h>

#import "GameViewController.h"
#import "CDSharedStructures.h"
#import "MatrixUtility.h"
#import "CDGameScene.h"
#import "CDSprite.h"
#import "CDMetalManager.h"

@implementation GameViewController {
    CDGameScene *_scene;
    UILabel *progress;
    NSTimer *timer;
    int currMinute;
    int currSeconds;
    
}
- (void)viewWillAppear{
    
    
}
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    CDMetalManager* manager = [CDMetalManager sharedManager];
    
    MTKView* view = (MTKView *)self.view;
    [view setSampleCount:1];
    view.delegate = manager;
    view.device = manager.device;
    [manager setMetalView:view];
    
    _scene = [[CDGameScene alloc] init];
    [manager setCurrentScene:_scene];
    progress=[[UILabel alloc] initWithFrame:CGRectMake(80, 15, 100, 50)];
    progress.textColor=[UIColor whiteColor];
    [progress setText:@"Time : 0:00"];
    progress.backgroundColor=[UIColor clearColor];
    [self.view addSubview:progress];
    currMinute=0;
    currSeconds=00;
    timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];

}

- (IBAction)start:(id)sender {
  
}


    
    

-(void)timerFired
{
    if((currMinute>0 || currSeconds>=0) && currMinute>=0)
    {
        if(currSeconds==0)
        {
            
            currSeconds=1;
        }
        else if(currSeconds>0)
        {
            currSeconds+=1;
        }
        if(currMinute>1)
            [progress setText:[NSString stringWithFormat:@"%@%d%@%02d",@"Time : ",currMinute,@":",currSeconds]];
    }
    else
    {
        [timer invalidate];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    vector_float2 position = [[CDMetalManager sharedManager] locationOfPoint:location];
    [_scene touchBeganAtLocation:position];
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    vector_float2 position = [[CDMetalManager sharedManager] locationOfPoint:location];
    [_scene touchMovedAtLocation:position];
}

@end

