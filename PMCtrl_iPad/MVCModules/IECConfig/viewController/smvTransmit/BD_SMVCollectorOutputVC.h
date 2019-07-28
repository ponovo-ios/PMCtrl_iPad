//
//  BD_SMVCollectorOutputVC.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/6.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BD_IECGooseSMVModel.h"
#import "BD_SMVBaseVC.h"
@interface BD_SMVCollectorOutputVC : BD_SMVBaseVC
@property(nonatomic,strong)NSMutableArray<BD_IECGooseSMVModel_CollectorOutputModel *> *topTBViewDataSource;

@end
