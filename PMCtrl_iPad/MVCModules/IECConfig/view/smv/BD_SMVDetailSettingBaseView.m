//
//  BD_SMVDetailSettingBaseView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/13.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_SMVDetailSettingBaseView.h"
#import "UIButton+Extension.h"
#import "BD_SMVDetailSettingWeakSignalMapBaseView.h"

@interface BD_SMVDetailSettingBaseView()

@end


@implementation BD_SMVDetailSettingBaseView

-(void)createViews{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    WeakSelf;
    //弱信号映射view
    
    BD_SMVDetailSettingWeakSignalMapBaseView *weakMapView = [[NSBundle mainBundle]loadNibNamed:@"BD_SMVDetailSettingWeakSignalMapBaseView" owner:self options:nil].lastObject;
    weakMapView.frame = CGRectMake(self.width-370, 10,370,self.height*0.8);
    [self addSubview:weakMapView];
    
    
    
    UIButton *cancelBtn = [[UIButton alloc]initWithTitle:@"取消" action:@selector(cancelAction:)];
    [self addSubview:cancelBtn];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakself.mas_bottom).offset(-20);
        make.right.mas_equalTo(weakself.mas_right).offset(-10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(30);
    }];
    
    //确定
    UIButton *okBtn = [[UIButton alloc]initWithTitle:@"确定" action:@selector(okAction:)];
    [self addSubview:okBtn];
    
    [okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(cancelBtn);
        make.right.mas_equalTo(cancelBtn.mas_left).offset(-10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(30);
    }];
    
    
    
    
    
    
}




//确定
-(void)okAction:(UIButton *)sender{
    self.okBlock();
}
//取消
-(void)cancelAction:(UIButton *)sender{
    self.cancelBlock();
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
