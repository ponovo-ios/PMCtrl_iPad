//
//  BD_StateTestCommomParamSetVC.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/1/5.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BD_StateTestCommonParamModel.h"
@interface BD_StateTestCommomParamSetVC : UIViewController

@property(nonatomic,strong)BD_StateTestCommonParamModel *paramDataModel;
@property(nonatomic,assign)CGFloat ratedVoltageMax;
@property(nonatomic,assign)CGFloat ratedCurrentMax;
-(void)showCommomParaView;
@end
