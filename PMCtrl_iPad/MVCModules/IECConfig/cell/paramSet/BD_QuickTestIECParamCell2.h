//
//  BD_QuickTestIECParamCell2.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/13.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *IEC设置  第一种cell 变比设置 电压／报文测试光口
 */
@interface BD_QuickTestIECParamCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellTitle;
@property (weak, nonatomic) IBOutlet UITextField *PTvoltage1;
@property (weak, nonatomic) IBOutlet UITextField *PTvoltage2;
@property (weak, nonatomic) IBOutlet UITextField *CTcurrent1;
@property (weak, nonatomic) IBOutlet UITextField *CTcurrent2;

@end
