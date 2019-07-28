//
//  BD_DifferentialSetParamSettingVC.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/10.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BD_DifferSetDataModel;
@interface BD_DifferentialSetParamSettingVC : UIViewController

@property (nonatomic, strong) NSMutableArray * setModelArray;   //plist
@property (nonatomic,strong)BD_DifferSetDataModel * setDataModel;
@property(nonatomic,strong)void(^okBlock)();
-(void)showSetParaView;
@end
