//
//  BD_GooseTransmitSCLFormCell.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/5.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BD_IECSCLBaseCell.h"
#import "BD_IECGooseTransmitModel.h"
@interface BD_GooseTransmitSCLFormCell : BD_IECSCLBaseCell
//设置cell数据
-(void)setDataToCellView:(BD_IECGooseTransmitSCLDataModel *)cellData;
@end
