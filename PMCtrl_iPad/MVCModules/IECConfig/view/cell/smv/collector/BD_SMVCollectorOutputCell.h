//
//  BD_SMVCollectorOutputCell.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/8.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BD_IECSCLBaseCell.h"
#import "BD_IECGooseSMVModel.h"
@interface BD_SMVCollectorOutputCell : BD_IECSCLBaseCell
//设置cell data 
-(void)setDataToCellView:(BD_IECGooseSMVModel_CollectorOutputModel *)cellData;
@end
