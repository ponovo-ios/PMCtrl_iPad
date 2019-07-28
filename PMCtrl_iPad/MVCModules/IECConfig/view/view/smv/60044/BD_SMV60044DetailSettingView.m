//
//  BD_SMV60044DetailSettingView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/12.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_SMV60044DetailSettingView.h"

@implementation BD_SMV60044DetailSettingView
-(void)createViews{
    [super createViews];
    WeakSelf;
    //报文参数设置
    BD_SMVDetailSettingMessageParamSetBaseView *messageSetView = [[BD_SMVDetailSettingMessageParamSetBaseView alloc]initWithArrs:
        @[@[@"SCP",@"SCM",@"CV   "],@[@"保护额定电流",@"零序额定电流",@"额定相电压"]]];
    
    [self addSubview:messageSetView];
    [messageSetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.mas_left).offset(10);
        make.width.mas_equalTo(weakself).multipliedBy(0.55);
        make.height.mas_equalTo(weakself).multipliedBy(0.4);
        make.top.mas_equalTo(weakself.mas_top).offset(10);
    }];
    [messageSetView createSubView];
    
    
    //参数设置选择view
    BD_SMVDetailSettingParamSetSelectionBaseView *paramSelectedView = [[BD_SMVDetailSettingParamSetSelectionBaseView alloc]init];
    
    [self addSubview:paramSelectedView];
    [paramSelectedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.mas_left).offset(10);
        make.width.mas_equalTo(150);
        make.top.mas_equalTo(messageSetView.mas_bottom).offset(20);
        make.bottom.mas_equalTo(weakself.mas_bottom).offset(-40);
    }];
    [paramSelectedView createViewsWithTitle:@"参数设置选择"];
    paramSelectedView.paramSelectedResult = ^(NSInteger resultTag) {
        DLog(@"选择类型:%ld",resultTag);
    };
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
