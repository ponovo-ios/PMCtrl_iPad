//
//  BD_HarmSwitchView.m
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/11/28.
//  Copyright © 2017年 ponovo. All rights reserved.
//  底部开关量视图

#import "BD_HarmSwitchView.h"

@implementation BD_HarmSwitchView

-(instancetype)init
{
    if (self = [super init]) {
        [self configureUI];
    }
    return self;
}

-(void)configureUI
{
    
    self.backgroundColor = MainBgColor;
    
    NSArray *titleArray = @[@"Run", @"P", @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"Ia", @"Ib", @"Ic", @"Va", @"Vb", @"Vc", @"V", @"OH", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8"];
    
    CGFloat btnX = 5;
    CGFloat btnY = Marge;
    CGFloat btnW = (Main_Screen_Width - 40 - (titleArray.count + 1) * btnX) / titleArray.count;
    CGFloat btnH = 40;
    
    for (NSInteger i = 0; i < titleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 200 + i;
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor lightGrayColor];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.frame = CGRectMake((btnX + btnW) * i + btnX, btnY, btnW, btnH);
        [self addSubview:button];
    }
}

- (void)drawRect:(CGRect)rect {
    
    self.layer.cornerRadius = Marge;
    
    self.layer.borderWidth = 1.5;
    
    self.layer.borderColor = BtnViewBorderColor.CGColor;
}


@end
