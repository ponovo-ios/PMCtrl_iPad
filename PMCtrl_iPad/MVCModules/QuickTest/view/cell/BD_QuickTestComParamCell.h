//
//  BD_QuickTestComParamCell.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/16.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *手动测试 通用参数设置页 定值 通用参数
 */
@interface BD_QuickTestComParamCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *celltitle;
@property (weak, nonatomic) IBOutlet UIButton *cellBtn;
@property (weak, nonatomic) IBOutlet UITextField *cellvalue;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property(nonatomic,assign)CGFloat ratedVoltageMax;
@property(nonatomic,assign)CGFloat ratedCurrentMax;

@property(nonatomic,strong)NSString *exchangeVoltageLimit;
@property(nonatomic,strong)NSString *exchangeCurrentLimit;
@property(nonatomic,strong)NSString *directVoltageLimit;
@property(nonatomic,strong)NSString *directCurrentLimit;

@property(nonatomic,assign)BOOL isDirectCurr;
@property (nonatomic,assign)NSIndexPath *cellIndex;
@property (nonatomic,strong)void(^popViewBlock)(NSIndexPath *,UITextField *);
@property (nonatomic,strong)void(^textFieldChangedBlock)(NSIndexPath *,NSString *);

@end
