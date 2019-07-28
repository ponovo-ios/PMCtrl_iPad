//
//  BD_SMVDetailSettingMarkPopViewManager.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/13.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_SMVDetailSettingMarkPopViewManager.h"

@interface BD_SMVDetailSettingMarkPopViewManager()


@end
@implementation BD_SMVDetailSettingMarkPopViewManager

-(void)instenceViews{
    _markView = [[UIView alloc]init];
    _markView.backgroundColor = [Black colorWithAlphaComponent:0.5];
    _detailView.layer.cornerRadius = 10;
    
    _detailView.layer.masksToBounds = YES;
    _detailView.backgroundColor = BDThemeColor;
    
    [_markView addSubview:self.detailView];
    
}
#pragma mark - 显示页面
-(void)showDetailViewWithRate:(CGFloat)widthRate height:(CGFloat)heightRate{
    
    UIViewController *window = [[UIApplication sharedApplication]keyWindow].rootViewController;
    self.markView.frame = window.view.bounds;
    [window.view addSubview:self.markView];
    _detailView.frame = CGRectZero;
    _detailView.center = _markView.center;//必须在此处给center赋值，如果在instenceViews中给—detailViewcenter赋值应为——markView都没有frame,所以—detailView的center一直为0
    [UIView animateWithDuration:0.3 animations:^{
        
        _detailView.frame = CGRectMake(0, 0,_markView.width*widthRate,_markView.height*heightRate);
        _detailView.center = _markView.center;
    } completion:^(BOOL finished) {
        
    }];
    
}
#pragma mark -消失页面
-(void)disMissDetailView{
    [UIView animateWithDuration:0.3 animations:^{
        
        _detailView.frame = CGRectZero;
        _detailView.center = _markView.center;
        
    } completion:^(BOOL finished) {
        [self.markView removeFromSuperview];
    }];
    
}

@end
