//
//  BD_SMV618502Cell.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/11.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BD_IECSCLBaseCell.h"
#import "BD_IECGooseSMVModel.h"
@interface BD_SMV618502Cell : BD_IECSCLBaseCell
//设置cell data
-(void)setDataToCellView:(BD_IECGooseSMVModel_618502Model *)cellData;
@end
