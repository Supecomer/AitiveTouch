//
//  CIAitiveTouchView.m
//  CIAitiveTouchFramework
//
//  Created by ciome on 2017/8/22.
//  Copyright © 2017年 ciome. All rights reserved.
//

#import "CIAitiveTouchView.h"
#import "CIDisplayLinkAnimation.h"


#define DEFAULT_RATE  0.1



@interface CIAitiveTouchView ()

@property (nonatomic,strong) CIDisplayLinkAnimation *displayLinkAnimation;
@property (nonatomic,assign) NSInteger  frameCount;
@property (nonatomic,assign) BOOL   isPan;
@property (nonatomic,assign) BOOL   isStartAnimation;
@property (nonatomic,assign) NSInteger direction;
@property (nonatomic,copy) voidBlock  tapVoidBlock;

@end


@implementation CIAitiveTouchView
@synthesize backgroundImage=_backgroundImage;


+ (CIAitiveTouchView *)getInstance
{
    static CIAitiveTouchView *touchView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        touchView = [[CIAitiveTouchView alloc] init];
    });
    return touchView;
}


- (id)init
{
    self = [super init];
    if (self) {
        _displayLinkAnimation = [[CIDisplayLinkAnimation alloc] initWithBlcok:^{
            [self animation];
           
        }];
        self.isPan = false;
        self.rate = DEFAULT_RATE;
        self.isStartAnimation = false;
        self.direction = 1;
        self.unactivityAlpha = 0.3;
        self.activityAlpha = 1.0;
        self.showTime = 0.3;
        self.hiddenTime = 0.3;
        self.alpha = self.unactivityAlpha;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
        [self addGestureRecognizer:pan];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}


#pragma mark - block

- (void)setTapGestureFuction:(voidBlock)block
{
    self.tapVoidBlock = block;
}



#pragma mark - gesture
- (void)panGesture:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan locationInView:[self superview]];
    switch (pan.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            if (self.isPan)
            {
                return;
            }
            self.alpha = _activityAlpha;
            self.isStartAnimation = false;
            self.isPan = true;
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            if (!self.isPan)
            {
                return;
            }
            // outline keep
            if (point.x<= self.frame.size.width/2)
            {
                point.x = self.frame.size.width/2;
            }
            
            if (point.x >= [self superview].frame.size.width - self.frame.size.width/2)
            {
                point.x = [self superview].frame.size.width - self.frame.size.width/2;
            }
            
            if (point.y<=self.frame.size.height/2)
            {
                point.y = self.frame.size.height/2;
            }
            
            if (point.y >= [self superview].frame.size.height- self.frame.size.height/2)
            {
                
                point.y = [self superview].frame.size.height- self.frame.size.height/2;
            }
            self.center = point;
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            if (!self.isPan)
            {
                return;
            }
            self.isPan = false;
            self.isStartAnimation = true;
        }
            break;
        default:
            break;
    }
}


- (void)tapGesture:(UITapGestureRecognizer *)tap
{
    switch (tap.state) {
       
        case UIGestureRecognizerStateEnded:
        {
            if (self.tapVoidBlock)
            {
                self.tapVoidBlock();
            }
            self.isStartAnimation = true;
        }
            break;
        default:
            break;

    }
}


- (NSString *)description
{
  return @"a aitiveTouch view ";
}


- (void)show
{
    [UIView animateWithDuration:self.showTime animations:^{
        self.alpha = self.unactivityAlpha;
    }];
}

- (void)hidden
{
    [UIView animateWithDuration:self.hiddenTime animations:^{
        self.alpha = 0.0;
    }];
}

- (void)remove
{
    [UIView animateWithDuration:self.hiddenTime animations:^{
        [self.displayLinkAnimation stop];
        [self  removeFromSuperview];
    }];
}


#pragma mark - property

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    if (backgroundImage)
    {
        self.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    }
    else
    {
        self.backgroundColor = [UIColor clearColor];
    }
}


- (void)setIsStartAnimation:(BOOL)isStartAnimation
{
    _isStartAnimation = isStartAnimation;
    _frameCount = 0;
    if (isStartAnimation) {
        // 判断方向
        if (self.center.x >= [[self superview] center].x) {
            _direction = 1;
        }
        else
        {
            _direction = -1;
        }
        [_displayLinkAnimation play];
    }
}



#pragma mark - action

- (void)animation
{
    if (!_isStartAnimation)
    {
        return;
    }
    _frameCount++;
    CGPoint center = self.center;
    center.x = center.x + _rate*_frameCount*_frameCount*_direction;
    if (_direction == 1)
    {
        if (center.x+self.frame.size.width/2 >= [self superview].frame.size.width)
        {
            center.x = [self superview].frame.size.width - self.frame.size.width/2;
            _isStartAnimation = false;
            [_displayLinkAnimation pause];
            [UIView animateWithDuration:self.hiddenTime animations:^{
                self.alpha = _unactivityAlpha;
            }];
        }
    }
    else
    {
        if (center.x - self.frame.size.width/2 <= 0)
        {
            center.x = self.frame.size.width/2;
            _isStartAnimation = false;
            [_displayLinkAnimation pause];
            [UIView animateWithDuration:self.hiddenTime animations:^{
                self.alpha = _unactivityAlpha;
            }];
        }
    }
    self.center = center;
}




@end

















