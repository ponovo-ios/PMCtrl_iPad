//
//  BD_SMVDetailSettingParamSetSelectionView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/12.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_SMVDetailSettingParamSetSelectionBaseView.h"

@interface BD_SMVDetailSettingParamSetSelectionBaseView()
@property(nonatomic,strong)UIButton *onceValueBtn;
@property(nonatomic,strong)UIButton *secondValueBtn;
@end

@implementation BD_SMVDetailSettingParamSetSelectionBaseView


-(void)createViewsWithTitle:(NSString *)str{
   [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    WeakSelf;
    UIView *bgView = [[UIView alloc]init];
    
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakself.mas_top).offset(0);
        make.left.mas_equalTo(weakself.mas_left).offset(0);
        make.bottom.mas_equalTo(weakself.mas_bottom).offset(0);
        make.right.mas_equalTo(weakself.mas_right).offset(0);
    }];
    [bgView setCorenerRadius:6.0 borderColor:RGB(234.0, 234.0, 234.0) borderWidth:1.0];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    [bgView addSubview:titleLabel];
    titleLabel.text = str;
    titleLabel.textColor = White;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgView.mas_top).offset(5);
        make.left.mas_equalTo(bgView.mas_left).offset(5);
        make.width.mas_equalTo(bgView).multipliedBy(0.9);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *oneBtn = [[UIButton alloc]init];
    [bgView addSubview:oneBtn];
//    radioSelected  radioUnSelected
    [oneBtn setImage:[UIImage imageNamed:@"radioSelected"] forState:UIControlStateSelected];
     [oneBtn setImage:[UIImage imageNamed:@"radioUnSelected"] forState:UIControlStateNormal];
    [oneBtn setSelected:YES];
    oneBtn.tag = 111;
    [oneBtn addTarget:self action:@selector(selectedParamAction:) forControlEvents:UIControlEventTouchUpInside];
    [oneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(bgView.mas_left).offset(5);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];
    _onceValueBtn = oneBtn;
    
    UILabel *oneLabel = [[UILabel alloc]init];
    [bgView addSubview:oneLabel];
    oneLabel.text = @"一次值";
    oneLabel.textColor = White;
    oneLabel.font = [UIFont systemFontOfSize:13];
    [oneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(oneBtn);
        make.left.mas_equalTo(oneBtn.mas_right).offset(5);
        make.width.mas_equalTo(bgView).multipliedBy(0.8);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *twoBtn = [[UIButton alloc]init];
    [bgView addSubview:twoBtn];
    //    radioSelected  radioUnSelected
    [twoBtn setImage:[UIImage imageNamed:@"radioSelected"] forState:UIControlStateSelected];
    [twoBtn setImage:[UIImage imageNamed:@"radioUnSelected"] forState:UIControlStateNormal];
    [twoBtn setSelected:NO];
    twoBtn.tag = 222;
    [twoBtn addTarget:self action:@selector(selectedParamAction:) forControlEvents:UIControlEventTouchUpInside];
    [twoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(oneBtn.mas_bottom).offset(5);
        make.left.mas_equalTo(bgView.mas_left).offset(5);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];
    _secondValueBtn = twoBtn;
    
    UILabel *twoLabel = [[UILabel alloc]init];
    [bgView addSubview:twoLabel];
    twoLabel.text = @"二次值";
    twoLabel.font = [UIFont systemFontOfSize:13];
    twoLabel.textColor = White;
    [twoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(twoBtn);
        make.left.mas_equalTo(twoBtn.mas_right).offset(5);
        make.width.mas_equalTo(bgView).multipliedBy(0.8);
        make.height.mas_equalTo(30);
    }];
}

-(void)selectedParamAction:(UIButton *)sender{
    switch (sender.tag) {
        case 111:
            [_onceValueBtn setSelected:YES];
            [_secondValueBtn setSelected:NO];
            break;
        case 222:
            [_onceValueBtn setSelected:NO];
            [_secondValueBtn setSelected:YES];
            break;
        default:
            break;
    }
    self.paramSelectedResult(sender.tag);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
