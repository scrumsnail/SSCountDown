//
//  UIButton+SSCountDown.m
//  SSCountDown
//
//  Created by allthings_LuYD on 16/8/23.
//  Copyright © 2016年 scrum_snail. All rights reserved.
//

#import "UIButton+SSCountDown.h"
#import <objc/runtime.h>

@interface UIButton()

@property(nonatomic, assign)BOOL ss_canDo;

@property(nonatomic, copy)BOOL (^ss_condition_block)();
@end


@implementation UIButton (SSCountDown)
static NSString * ss_oldText;
static NSInteger  ss_countDown_time;
static NSString * ss_countDown_title;

static NSString * ss_sender_key = @"ss_sender";

static NSString * ss_canDo_key = @"ss_canDo_key";

static NSString * ss_conditionBlock_key = @"ss_conditionBlock_key";

#pragma mark - set get

- (void)setSs_sender:(id)ss_sender {
    objc_setAssociatedObject(self, &ss_sender_key, ss_sender, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)ss_sender {
    return objc_getAssociatedObject(self, &ss_sender_key);
}


- (void)setSs_canDo:(BOOL)ss_canDo {
    objc_setAssociatedObject(self, &ss_canDo_key, @(ss_canDo), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)ss_canDo {
    return [objc_getAssociatedObject(self, &ss_canDo_key) boolValue];
}

- (void)setSs_condition_block:(BOOL (^)())ss_condition_block {
    objc_setAssociatedObject(self, &ss_conditionBlock_key, ss_condition_block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL (^)())ss_condition_block {
    return objc_getAssociatedObject(self, &ss_conditionBlock_key);
}

- (void)ss_countDown:(NSUInteger)time title:(NSString *)title {
    ss_countDown_title = title;
    [self ss_countDown:time];
}

- (void)ss_countDown:(NSUInteger)time {
    ss_oldText = self.titleLabel.text;
    ss_countDown_time = time;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self addTarget:self action:@selector(_ss_btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)_ss_btnClick:(UIButton *)sender {
    if (self.ss_sender) {
        if (self.ss_canDo) {
            [self ss_timeCountDown];
        }
    } else if (self.ss_condition_block) {
        self.ss_canDo = self.ss_condition_block();
        if (self.ss_canDo) {
            [self ss_timeCountDown];
        }
    } else {
        [self ss_timeCountDown];
    }
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


- (void)ss_addCondition:(BOOL (^)())condition {
    self.ss_condition_block = condition;
}


@end
