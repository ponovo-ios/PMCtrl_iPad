//
//  BD_IECParamCell3.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/29.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BD_IECParamCell3 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellTitle;
@property (weak, nonatomic) IBOutlet UILabel *cellValue1;
@property (weak, nonatomic) IBOutlet UIButton *cellBtn1;
@property (weak, nonatomic) IBOutlet UIButton *cellBtn2;
@property (weak, nonatomic) IBOutlet UILabel *cellValue2;
@property (nonatomic,copy) void(^radioSelectedBlock)(int);//单项选择回调方法，0 第一项 1 第二项
@end
