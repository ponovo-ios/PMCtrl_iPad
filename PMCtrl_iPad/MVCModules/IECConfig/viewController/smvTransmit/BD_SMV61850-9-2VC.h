//
//  BD_SMV61850-9-2VC.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/6.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BD_SMVBaseVC.h"
#import "BD_IECGooseSMVModel.h"
@interface BD_SMV61850_9_2VC : BD_SMVBaseVC
@property(nonatomic,strong)NSMutableArray<BD_IECGooseSMVModel_618502Model *> *topTBViewDataSource;
@end
