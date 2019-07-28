//
//  BD_GooseSubSCLFormCell.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/29.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BD_IECSCLBaseCell.h"
#import "BD_IECGooseSubscriptionModel.h"
@interface BD_GooseSubSCLFormCell : BD_IECSCLBaseCell
-(void)setDataToCellView:(BD_IECGooseSubscriptionSCLDataModel *)cellData;
@end
