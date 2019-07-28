//
//  BD_SMV618502DetailSettingView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/12.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_SMV618502DetailSettingView.h"
#import "BD_SMVScalefactorSettingView.h"
@implementation BD_SMV618502DetailSettingView

-(void)createViews{
    [super createViews];
    WeakSelf;
    //报文参数设置
    BD_SMVScalefactorSettingView *scalefactorView = [[NSBundle mainBundle]loadNibNamed:@"BD_SMVScalefactorSettingView" owner:nil options:nil].lastObject;
    
    [self addSubview:scalefactorView];
    [scalefactorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.mas_left).offset(10);
        make.width.mas_equalTo(weakself).multipliedBy(0.45);
        make.height.mas_equalTo(weakself).multipliedBy(0.65);
        make.top.mas_equalTo(weakself.mas_top).offset(10);
    }];
    
    //同步输出选择框
    UIButton *outputBtn = [[UIButton alloc]init];
    [self addSubview:outputBtn];
    //    radioSelected  radioUnSelected
    [outputBtn setImage:BD_SelectedImage forState:UIControlStateSelected];
    [outputBtn setImage:BD_UnSelectedImage forState:UIControlStateNormal];
    [outputBtn setSelected:NO];
    [outputBtn addTarget:self action:@selector(qualitySelect:) forControlEvents:UIControlEventTouchUpInside];
    [outputBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakself.mas_bottom).offset(-20);
        make.left.mas_equalTo(weakself.mas_left).offset(5);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];
    
    //同步输出label
    UILabel *outputLabel = [[UILabel alloc]init];
    [self addSubview:outputLabel];
    outputLabel.text = @"不包含品质位";
    outputLabel.textColor = White;
    [outputLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(outputBtn);
        make.left.mas_equalTo(outputBtn.mas_right).offset(5);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(30);
    }];
    
    
    //参数设置选择view
    BD_SMVDetailSettingParamSetSelectionBaseView *paramSelectedView = [[BD_SMVDetailSettingParamSetSelectionBaseView alloc]init];
    
    [self addSubview:paramSelectedView];
    [paramSelectedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.mas_left).offset(10);
        make.width.mas_equalTo(150);
        make.top.mas_equalTo(scalefactorView.mas_bottom).offset(20);
        make.bottom.mas_equalTo(outputBtn.mas_top).offset(-10);
    }];
    [paramSelectedView createViewsWithTitle:@"参数设置选择"];
    paramSelectedView.paramSelectedResult = ^(NSInteger resultTag) {
        DLog(@"选择类型:%ld",resultTag);
    };
    
    //报文输出选择
    BD_SMVDetailSettingParamSetSelectionBaseView *messageOutputSelectedView = [[BD_SMVDetailSettingParamSetSelectionBaseView alloc]init];
    
    [self addSubview:messageOutputSelectedView];
    [messageOutputSelectedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(paramSelectedView.mas_right).offset(10);
        make.width.mas_equalTo(150);
        make.top.mas_equalTo(scalefactorView.mas_bottom).offset(20);
        make.bottom.mas_equalTo(outputBtn.mas_top).offset(-10);
    }];
    [messageOutputSelectedView createViewsWithTitle:@"报文输出选择"];
    messageOutputSelectedView.paramSelectedResult = ^(NSInteger resultTag) {
        DLog(@"选择类型:%ld",resultTag);
    };
}


-(void)qualitySelect:(UIButton *)sender{
    [sender setSelected:!sender.selected];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
