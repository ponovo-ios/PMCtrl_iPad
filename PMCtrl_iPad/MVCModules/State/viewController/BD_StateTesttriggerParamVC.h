//
//  BD_StateTesttriggerParamVC.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/25.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BD_StateTriggerView;
@class BD_StateTestTriggerParamModel;
@class BD_StateTestTransmutationDetailModel;
@interface BD_StateTesttriggerParamVC : UIViewController
@property (nonatomic, copy) BD_StateTestTriggerParamModel * dataModel;

@property(nonatomic,strong)BD_StateTestTransmutationDetailModel *gradientModel;

@property (nonatomic, strong) BD_StateTriggerView * trigView;

//变量类型数组
@property(nonatomic,strong)NSArray *paramTypeArr;

@end
