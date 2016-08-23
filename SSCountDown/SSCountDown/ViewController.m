//
//  ViewController.m
//  SSCountDown
//
//  Created by allthings_LuYD on 16/8/23.
//  Copyright © 2016年 scrum_snail. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+SSCountDown.h"
@interface ViewController (){
    UIButton * btn;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds = CGRectMake(0, 0, 100, 50);
    btn.center = self.view.center;
    [btn setTitle:@"发送验证码" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn ss_countDown:3 title:@"s再发送"];
    [btn ss_addCondition:^BOOL{
        return 1 > 0;
    }];
    [self.view addSubview:btn];
}

@end
