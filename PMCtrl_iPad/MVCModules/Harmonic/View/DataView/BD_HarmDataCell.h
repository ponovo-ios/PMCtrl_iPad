//
//  BD_HarmDataCell.h
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/12/1.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BD_HarmCellModel.h"
@protocol BDHarmDataCellEditDelegate<NSObject>
@required
-(NSArray *)getLimitValues;
@end
@interface BD_HarmDataCell : UITableViewCell

//含有率
@property (weak, nonatomic) IBOutlet UITextField *firstContainingRateTF;
@property (weak, nonatomic) IBOutlet UITextField *secondContainingRateTF;
@property (weak, nonatomic) IBOutlet UITextField *thirdContainingRateTF;
@property (weak, nonatomic) IBOutlet UITextField *fourthContainingRateTF;

/**点击选择按钮回调*/
@property (nonatomic, copy) void(^clickSelectBtn)(NSInteger index, UIButton *sender);

/**基波数值*/
@property (nonatomic, strong) BD_HarmCellModel *baseCellModel;


/**index*/
@property (nonatomic, assign) NSInteger index;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view4Constraint;
//选择按钮
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
//谐波次数
@property (weak, nonatomic) IBOutlet UILabel *harmNumLabel;

/**绑定数据*/
@property (nonatomic, strong) BD_HarmCellModel *cellModel;
@property(nonatomic,strong)NSArray<NSNumber *> *limitValueArr;
/**某一值改变回调*/
@property (nonatomic, copy) void (^changeValue)(NSInteger index);
@property (nonatomic,strong)id<BDHarmDataCellEditDelegate> editDelegate;
//回退操作
-(void)goBack;

@end
