//
//  BD_SMV618502QualityView.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/14.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
/**  电压映射列表第4列品质设置弹出view*/
@interface BD_SMV618502QualityView : UIView


@property(nonatomic,strong)void((^okBlock)());
@property(nonatomic,strong)void((^cancelBlock)());
@end
