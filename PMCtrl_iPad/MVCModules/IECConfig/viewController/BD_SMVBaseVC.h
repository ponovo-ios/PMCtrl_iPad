//
//  BD_SMVBaseVC.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/1/3.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BD_PopListViewManager.h"
@interface BD_SMVBaseVC : BD_BaseVC
@property(nonatomic,strong)UIScrollView *topscrollView;
@property(nonatomic,strong)UITableView *topTableView;
@property(nonatomic,assign)NSInteger selectedCellIndex;

-(void)confitViews;
@end
