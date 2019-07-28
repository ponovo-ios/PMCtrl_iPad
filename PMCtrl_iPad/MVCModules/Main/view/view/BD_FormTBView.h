//
//  BD_QuickSequenceComTBView.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/21.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BD_FormTBViewBaseModel;
@interface BD_FormTBView : UITableView
@property(nonatomic,strong)NSArray<NSArray<NSString *> *> *headerTitles;
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style headerTitles:(NSArray *)headerTitles;
@property(nonatomic,strong)NSArray<NSArray<BD_FormTBViewBaseModel *> *> *formDatasource;
@end
