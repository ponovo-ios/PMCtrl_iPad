//
//  BD_DifferentialGeneralTBView.h
//  PMCtrl_iOS
//
//  Created by ponovo on 2017/8/29.
//  Copyright © 2017年 bodian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeneralParaModel.h"
@interface BD_DifferentialGeneralTBView : UITableView
@property (nonatomic, strong) NSMutableArray * modelArr;
@property (nonatomic,strong)NSMutableArray *generalBaseArr;

@property (nonatomic, copy) void(^generalResultBlock)(NSMutableArray *resultArr);
@property (nonatomic,copy) void(^showGeneralBlock)(UIButton *btn);
-(void)endEditing;

@end
