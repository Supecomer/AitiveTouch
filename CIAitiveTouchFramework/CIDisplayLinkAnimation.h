//
//  CIDisplayLinkAnimation.h
//  CIAitiveTouchFramework
//
//  Created by ciome on 2017/8/22.
//  Copyright © 2017年 ciome. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>


typedef void(^blockFuc)(void);


@interface CIDisplayLinkAnimation : NSObject


- (instancetype)initWithBlcok:(blockFuc)block;



- (void)play;
- (void)pause;
- (void)stop;



@end
