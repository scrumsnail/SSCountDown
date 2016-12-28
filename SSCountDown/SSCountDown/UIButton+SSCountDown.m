//
//  UIButton+SSCountDown.m
//  SSCountDown
//
//  Created by allthings_LuYD on 16/8/23.
//  Copyright © 2016年 scrum_snail. All rights reserved.
//

#import "UIButton+SSCountDown.h"


@implementation UIButton (SSCountDown)
static NSString * ss_oldText;
static NSInteger  ss_countDown_time;
static NSString * ss_countDown_title;

- (void)ss_countDown:(NSUInteger)time title:(NSString *)title {
    ss_countDown_title = title;
    ss_countDown_time = time;
    [self ss_countDown];
}

- (void)ss_countDown{
    ss_oldText = self.titleLabel.text;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self addTarget:self action:@selector(_ss_btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)_ss_btnClick:(UIButton *)sender {
    [self ss_timeCountDown];
}

- (void)ss_timeCountDown {
    self.enabled = NO;
    [self setTitle:[NSString stringWithFormat:@"%lu%@",ss_countDown_time,ss_countDown_title] forState:UIControlStateNormal];
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(ss_timeCountDownTitleChange:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)ss_timeCountDownTitleChange:(NSTimer *)timer {
    NSInteger time = [self.titleLabel.text integerValue];
    time--;
    if (time == 0) {
        [self setTitle:ss_oldText forState:UIControlStateNormal];
        [timer invalidate];
        self.enabled = YES;
        return;
    }

    [self setTitle:[NSString stringWithFormat:@"%lu%@",time,ss_countDown_title] forState:UIControlStateNormal];
}


@end
