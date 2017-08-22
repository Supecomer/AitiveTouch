//
//  ViewController.m
//  demo
//
//  Created by ciome on 2017/8/22.
//  Copyright © 2017年 ciome. All rights reserved.
//

#import "ViewController.h"
#import <CIAitiveTouchFramework/CIAitiveTouchFramework.h>



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blackColor];
//    UIView  *view = [[UIView alloc] initWithFrame:CGRectMake(10, 20, 200, 400)];
//    view.backgroundColor = [UIColor purpleColor];
//    [self.view addSubview:view];
    
    
    CIAitiveTouchView *touchView = [[CIAitiveTouchView alloc] init];
    touchView.backgroundColor = [UIColor orangeColor];
    touchView.frame = CGRectMake(0, 0, 100, 100);
    [self.view addSubview:touchView];
    UILabel  *lb = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
    lb.text = @"test ";
    [touchView addSubview:lb];
    __block NSInteger times = 1;
    [touchView setTapGestureFuction:^{
        __weak UILabel *label = lb;
        label.text = [NSString stringWithFormat:@"text %ld",times++];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
