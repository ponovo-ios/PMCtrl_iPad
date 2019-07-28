//
//  BD_StateTestShowtCalculationVC.h
//  PMCtrl_iPad
//
//  Created by 张姝枫 on 2018/1/7.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BD_ShortCaculationModel.h"
@interface BD_StateTestShowtCalculationVC : UIViewController

//短路计算数据
@property(nonatomic,strong)BD_ShortCaculationModel *cacultationModel;
@property(nonatomic,assign)NSInteger groupNum;
//配置子view的样式
-(void)confitSubViews;
@property(nonatomic,strong)void(^okActionBlock)();
-(void)showBinaryInView;
@end
