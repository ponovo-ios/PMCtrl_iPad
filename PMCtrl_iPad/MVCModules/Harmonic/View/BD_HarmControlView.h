//
//  BD_HarmControlView.h
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/11/28.
//  Copyright © 2017年 ponovo. All rights reserved.
//  顶部控制台视图

#import <UIKit/UIKit.h>


@protocol BD_HarmControlViewDelegate<NSObject>

-(void)didSelectedButton:(UIButton *)button;

@end

@interface BD_HarmControlView : UIView
/**开始按钮*/
@property (nonatomic, weak) UIButton *startBtn;
/**选择按钮代理*/
@property (nonatomic, weak) id<BD_HarmControlViewDelegate> delegate;
//设置锁定按钮是否可用
-(void)setLockBtnIsUsed:(BOOL)isUsed;


@end
