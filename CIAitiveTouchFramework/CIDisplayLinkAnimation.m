//
//  CIDisplayLinkAnimation.m
//  CIAitiveTouchFramework
//
//  Created by ciome on 2017/8/22.
//  Copyright © 2017年 ciome. All rights reserved.
//

#import "CIDisplayLinkAnimation.h"


typedef NS_ENUM(NSUInteger, CIAnimationStatus) {
    enum_animationStatus_play,
    enum_animationStatus_pause,
    enum_animationStatus_stop
};




@interface CIDisplayLinkAnimation ()

/**
 硬件刷帧定时器
 */
@property (nonatomic,strong) CADisplayLink  *displayLink;
@property (nonatomic,assign) CIAnimationStatus  animationStatus;
@property (nonatomic,copy) blockFuc  blockFuction;


@end





@implementation CIDisplayLinkAnimation



- (instancetype)initWithBlcok:(blockFuc)block
{
    if (self = [super init]) {
        
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(animationPool)];
        self.animationStatus = enum_animationStatus_pause;
        self.blockFuction=block;
        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        
    }
    return self;
}


- (void)animationPool
{
    if (self.blockFuction) {
        self.blockFuction();
    }
}


#pragma mark - action


- (void)play
{
    if (self.animationStatus != enum_animationStatus_play)
    {
        self.animationStatus = enum_animationStatus_play;
        [self.displayLink setPaused:false];
    }
}


- (void)pause
{
    self.animationStatus = enum_animationStatus_pause;
    [self.displayLink setPaused:true];
}


- (void)stop
{
    self.animationStatus = enum_animationStatus_stop;
    [self.displayLink setPaused:true];
    [self.displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (NSString *)description
{
   return @"this class is animation baseClass base of displayLink";
}

@end
