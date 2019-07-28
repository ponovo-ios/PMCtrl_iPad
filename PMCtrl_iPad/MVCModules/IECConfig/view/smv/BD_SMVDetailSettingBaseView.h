//
//  BD_SMVDetailSettingBaseView.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/13.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BD_SMVDetailSettingMessageParamSetBaseView.h"
#import "BD_SMVDetailSettingParamSetSelectionBaseView.h"
/**详细设置基础view 包含统一的确定 取消 弱信号映射*/
@interface BD_SMVDetailSettingBaseView : UIView
-(void)createViews;

@property(nonatomic,strong)void((^okBlock)());
@property(nonatomic,strong)void((^cancelBlock)());
@end
