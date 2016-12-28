//
//  UIButton+SSCountDown.h
//  SSCountDown
//
//  Created by allthings_LuYD on 16/8/23.
//  Copyright © 2016年 scrum_snail. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (SSCountDown)



/**
 *  倒计时设置
 *
 *  @param time  时间
 *  @param title 时间后的文字
 */
- (void)ss_countDown:(NSUInteger)time title:(NSString *)title;




@end
