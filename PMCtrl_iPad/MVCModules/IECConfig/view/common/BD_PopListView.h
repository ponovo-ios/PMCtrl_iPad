//
//  BD_PopListView.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/6.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BD_PopListView : UIViewController
@property(nonatomic,strong)NSArray *listdatasource;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,copy)void(^selecteTitleBlock)(NSString *);
@end
