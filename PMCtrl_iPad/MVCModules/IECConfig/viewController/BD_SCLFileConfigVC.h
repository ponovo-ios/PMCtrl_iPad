//
//  BD_SCLFileConfigVC.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/3.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BD_IEDInfoModel;
@interface BD_SCLFileConfigVC : UIViewController
@property(nonatomic,strong)NSMutableArray<BD_IEDInfoModel *> *sclDataSource;

- (instancetype)initWithDataSource:(NSMutableArray *)datasource;
@end
