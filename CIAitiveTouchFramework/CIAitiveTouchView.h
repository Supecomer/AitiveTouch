//
//  CIAitiveTouchView.h
//  CIAitiveTouchFramework
//
//  Created by ciome on 2017/8/22.
//  Copyright © 2017年 ciome. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^voidBlock)(void);

@interface CIAitiveTouchView : UIView


/**
 animation rate,default  1.0
 */
@property (nonatomic,assign) float  rate;
/**
  alpha when activity,default 1.0
 */
@property (nonatomic,assign) float  activityAlpha;

/**
 alpha when unactivity,default 0.3
 */
@property (nonatomic,assign) float  unactivityAlpha;

/**
 show time ,defulat 0.2s
 */
@property (nonatomic,assign) float  showTime;

/**
 hiddenTime time ,defulat 0.2s
 */
@property (nonatomic,assign) float  hiddenTime;

/**
 background image,defualt is nill
 */
@property (nonatomic,strong) UIImage  *backgroundImage;


- (void)setTapGestureFuction:(voidBlock)block;


+ (CIAitiveTouchView *)getInstance;


- (void)show;
- (void)hidden;
- (void)remove;

@end





