//
//  BD_DifferentialSettingVC.h
//  PMCtrl_iOS
//
//  Created by wang on 2017/5/30.
//  Copyright © 2017年 wgx. All rights reserved.
//  设置

#import <UIKit/UIKit.h>
@class BD_DifferGeneralSetDataModel;
@interface BD_DifferentialGeneralSettingVC : UIViewController
@property (nonatomic, strong) NSMutableArray * generModelArray;   //plist
@property (nonatomic,strong)BD_DifferGeneralSetDataModel * generalDataParam;
@property(nonatomic,strong)void(^okBlock)();
-(void)showGeneralParaView;

@end
