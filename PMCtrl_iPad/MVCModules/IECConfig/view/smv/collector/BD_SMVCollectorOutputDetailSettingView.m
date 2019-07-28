//
//  BD_SMVCollectorOutputDetailSettingView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/11.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_SMVCollectorOutputDetailSettingView.h"
#import "BD_SMVDetailSettingMessageParamSetBaseView.h"
#import "BD_SMVDetailSettingParamSetSelectionBaseView.h"
#import "UIButton+Extension.h"
@interface BD_SMVCollectorOutputDetailSettingView()

@end

@implementation BD_SMVCollectorOutputDetailSettingView

-(void)createViews{
    [super createViews];
    WeakSelf;
    //报文参数设置
    BD_SMVDetailSettingMessageParamSetBaseView *messageSetView = [[BD_SMVDetailSettingMessageParamSetBaseView alloc]initWithArrs:@[@[@"保护额定电流",@"零序额定电流",@"额定相电压"]]];
    
    [self addSubview:messageSetView];
    [messageSetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.mas_left).offset(10);
        make.width.mas_equalTo(weakself).multipliedBy(0.45);
        make.height.mas_equalTo(weakself).multipliedBy(0.4);
        make.top.mas_equalTo(weakself.mas_top).offset(10);
    }];
    [messageSetView createSubView];
    //同步输出选择框
    UIButton *outputBtn = [[UIButton alloc]init];
    [self addSubview:outputBtn];
    //    radioSelected  radioUnSelected
    [outputBtn setImage:BD_SelectedImage forState:UIControlStateSelected];
    [outputBtn setImage:BD_UnSelectedImage forState:UIControlStateNormal];
    [outputBtn setSelected:NO];
    [outputBtn addTarget:self action:@selector(stepOutputAction:) forControlEvents:UIControlEventTouchUpInside];
    [outputBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakself.mas_bottom).offset(-self.height*0.21);
        make.left.mas_equalTo(weakself.mas_left).offset(5);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];
    
    //同步输出label
    UILabel *outputLabel = [[UILabel alloc]init];
    [self addSubview:outputLabel];
    outputLabel.text = @"同步输出";
    outputLabel.textColor = White;
    [outputLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(outputBtn);
        make.left.mas_equalTo(outputBtn.mas_right).offset(5);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    
    
    //参数设置选择view
    BD_SMVDetailSettingParamSetSelectionBaseView *paramSelectedView = [[BD_SMVDetailSettingParamSetSelectionBaseView alloc]init];
    
    [self addSubview:paramSelectedView];
    [paramSelectedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.mas_left).offset(10);
        make.width.mas_equalTo(weakself).multipliedBy(0.3);
        make.top.mas_equalTo(messageSetView.mas_bottom).offset(20);
        make.bottom.mas_equalTo(outputBtn.mas_top).offset(-10);
    }];
    [paramSelectedView createViewsWithTitle:@"参数设置选择"];
    
    
}

//同步输出？选择
-(void)stepOutputAction:(UIButton *)sender{
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
