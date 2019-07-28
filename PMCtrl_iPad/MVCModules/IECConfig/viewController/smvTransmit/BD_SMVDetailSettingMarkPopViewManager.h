//
//  BD_SMVDetailSettingMarkPopViewManager.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/13.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BD_SMVDetailSettingMarkPopViewManager : NSObject
@property(nonatomic,strong)UIView  *detailView;
@property (nonatomic,strong)UIView *markView;

/**初始化蒙版 和详细页面*/
-(void)instenceViews;
/**显示页面*/
-(void)showDetailViewWithRate:(CGFloat)widthRate height:(CGFloat)heightRate;
/**消失页面*/
-(void)disMissDetailView;
    
@end
