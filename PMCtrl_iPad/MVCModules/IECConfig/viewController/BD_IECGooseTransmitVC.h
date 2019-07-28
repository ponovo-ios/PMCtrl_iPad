//
//  BD_IECGooseTransmitVC.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/23.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BD_IECGooseTransmitModel.h"
#import "BD_SMVBaseVC.h"
@interface BD_IECGooseTransmitVC : BD_SMVBaseVC
@property(nonatomic,strong)NSMutableArray<BD_IECGooseTransmitSCLDataModel *> *topTBViewDataSource;
@property(nonatomic,strong)NSMutableArray<BD_IECGooseTransmitPassageModel *> *bottomTBViewDataSource;
@end
