//
//  BD_SMVDetailSettingParamSetSelectionView.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/12.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
/**smv分页 详细设置 参数设置选择view*/
@interface BD_SMVDetailSettingParamSetSelectionBaseView : UIView
@property(nonatomic,strong)void(^paramSelectedResult)(NSInteger);

-(void)createViewsWithTitle:(NSString *)str;//111 表示选择一次值 222表示选择二次值

@end
