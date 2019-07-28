//
//  BD_IECGooseSubscriptionVC.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/23.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BD_IECGooseSubscriptionModel.h"
#import "BD_IECGooseTransmitModel.h"
@interface BD_IECGooseSubscriptionVC : BD_BaseVC
@property(nonatomic,strong)NSMutableArray<BD_IECGooseSubscriptionSCLDataModel *> *topTBViewDataSource;
@property(nonatomic,strong)NSMutableArray<BD_IECGooseSubscriptionPassageMapModel *>*rightTBViewDataSource;

@property(nonatomic,strong)NSMutableArray<BD_IECGooseTransmitPassageModel *> *leftTBViewDataSource;
@end
