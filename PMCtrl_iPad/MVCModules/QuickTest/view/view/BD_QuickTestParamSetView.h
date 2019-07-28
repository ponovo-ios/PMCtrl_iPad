//
//  BD_QuickTestParamSetView.h
//  PMCtrl_iPad
//
//  Created by 张姝枫 on 2017/10/15.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BD_QuickTestPickerModel;
@class BD_QuickTestComSetModel;
@class BD_BinaryInSettingModel;
@class BD_PassagewayNumModel;
@protocol BDBinaryChangedProtocol<NSObject>

@required
-(void)changeBinaryState:(int)binaryNum;
-(void)changeBinaryoutStateOntimer:(int)binaryNum;
-(void)changeResultViewBackViewShow:(int)autoChangeStyle;
-(void)changeRateVolCurrFre;
@end

/**
 *手动测试 通用参数设置页面
 */
@interface BD_QuickTestParamSetView : UIView
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSString *selectedStr;
/** picker选择变量的参数*/
@property (nonatomic,strong)BD_QuickTestPickerModel *pickerModel;
/** 参数模型*/
@property (nonatomic,strong)BD_QuickTestComSetModel *comParam;
/**通道个数模型*/
@property (nonatomic,strong)BD_PassagewayNumModel *passagewayNum;

@property (nonatomic,assign)bool isBegin;
//额定电压 和额定电流限制
@property(nonatomic,assign)CGFloat ratedVoltageMax;
@property(nonatomic,assign)CGFloat ratedCurrentMax;

@property(nonatomic,weak)id<BDBinaryChangedProtocol> binaryDelegate;
@property(nonatomic,strong)void(^reportVCShowBlock)(UIView *);
@end
