//
//  BD_StateTriggerView.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/6/12.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BD_StateTestTransmutationDetailModel;
@interface BD_StateTriggerView : UIView

//0: 手动触发 1:时间触发单位ms 2:开入变位触发 3:GPS触发
@property (weak, nonatomic) IBOutlet UIButton *nTrigerTypeBtn;

//逻辑或、与
@property (strong, nonatomic) IBOutlet UISegmentedControl *nTrigerLogic;

//时间触发参数或 GPS触发秒数
@property (strong, nonatomic) IBOutlet UITextField *nTirgerTime;

@property (strong, nonatomic) IBOutlet UISwitch *BA;
@property (strong, nonatomic) IBOutlet UISwitch *BB;
@property (strong, nonatomic) IBOutlet UISwitch *BC;
@property (strong, nonatomic) IBOutlet UISwitch *BD;
@property (strong, nonatomic) IBOutlet UISwitch *BE;
@property (strong, nonatomic) IBOutlet UISwitch *BF;
@property (strong, nonatomic) IBOutlet UISwitch *BG;
@property (strong, nonatomic) IBOutlet UISwitch *BH;
@property (strong, nonatomic) IBOutlet UISwitch *BI;
@property (strong, nonatomic) IBOutlet UISwitch *BJ;

@property (strong, nonatomic) IBOutlet UISwitch *Bo01;
@property (strong, nonatomic) IBOutlet UISwitch *Bo02;
@property (strong, nonatomic) IBOutlet UISwitch *Bo03;
@property (strong, nonatomic) IBOutlet UISwitch *Bo04;
@property (strong, nonatomic) IBOutlet UISwitch *Bo05;
@property (strong, nonatomic) IBOutlet UISwitch *Bo06;
@property (strong, nonatomic) IBOutlet UISwitch *Bo07;
@property (strong, nonatomic) IBOutlet UISwitch *Bo08;

@property (strong, nonatomic) IBOutlet UIView *binaryInV;
@property (strong, nonatomic) IBOutlet UIView *binaryOutV;

@property (weak, nonatomic) IBOutlet UITextField *delayTimeTF;
/** 触发时刻 */

@property (weak, nonatomic) IBOutlet UIButton *triggerMomentPickerBtn;
/**递变设置*/
@property (weak, nonatomic) IBOutlet UIView *transmutationView;
@property (weak, nonatomic) IBOutlet UIButton *dfBtn;

@property (weak, nonatomic) IBOutlet UIButton *dvBtn;

@property (weak, nonatomic) IBOutlet UIButton *transmutationBtn;

@property (weak, nonatomic) IBOutlet UIButton *transmutationSettingDetailBtn;
/** 保持时间 */

@property (weak, nonatomic) IBOutlet UIButton *holdTimeBtn;
@property (weak, nonatomic) IBOutlet UITextField *holdTimeTF;
@property (weak, nonatomic) IBOutlet UILabel *holdTimeLabel;

@property(nonatomic,assign)NSInteger triggerTypeIndex;
//递变设置模型
@property(nonatomic,strong)BD_StateTestTransmutationDetailModel *gradientModel;
//变量类型数组
@property(nonatomic,strong)NSArray *paramTypeArr;
/**
 *触发条件编辑完成后，回调，通知VC修改数据源
 */
@property(nonatomic,strong)void(^endEditViewBlock)();
//保持时间是否可用
-(void)setHoldTimeUserInteractionState:(BOOL)state;
//递变设置是否可用
-(void)setTransmutationUserInteractionState:(BOOL)state;

@end
