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

    // test in self
//    [self testInView];
    
    // test in a subview
    [self testViewInView];
    [self testViewInView1];
    
}

- (void)testInView
{
    [self.view addSubview:[self getTouchView]];

}


- (CIAitiveTouchView *)getTouchView
{
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
    return touchView;
}


-(void)testViewInView
{
    UIView  *view = [[UIView alloc] initWithFrame:CGRectMake(10, 20, 200, 300)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    [view addSubview:[self getTouchView]];
}

-(void)testViewInView1
{
    UIView  *view = [[UIView alloc] initWithFrame:CGRectMake(10, 330, 200, 300)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    [view addSubview:[self getTouchView]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
