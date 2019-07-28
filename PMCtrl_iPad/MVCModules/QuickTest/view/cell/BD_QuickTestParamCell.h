//
//  BD_QuickTestParamCell.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/10.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BD_TestDataParamModel;

/**
 cell类型，区分是电压还是电流
 */
typedef NS_ENUM(NSInteger,BD_CellType){
    BD_CellTypeVoltage = 0,
    BD_CellTypeCurrent =  1
};
/**
 *手动测试页面 数据页 cell 设置6相电流电压
 */
@interface BD_QuickTestParamCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellTitle;
@property (weak, nonatomic) IBOutlet UITextField *amplitude;
@property (weak, nonatomic) IBOutlet UITextField *phase;
@property (weak, nonatomic) IBOutlet UITextField *frequency;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (nonatomic, copy) NSString *selectedStr;

@property (nonatomic, copy) NSString * stepValue;

@property (nonatomic, assign) BOOL isBegin;
@property (nonatomic,assign) BOOL isDirectCurr;
@property (nonatomic, assign) BOOL isLock;
@property (nonatomic, assign) BD_CellType cellType;
@property (nonatomic, strong)void (^quickParamBlock)(BD_TestDataParamModel *);
-(void)setVolCurrDefaultLimitWithExVol:(NSString *)exVol exCurr:(NSString *)exCurr DV:(NSString *)DV DC:(NSString *)DC;
@end
