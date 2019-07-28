//
//  BD_ReprotFormView.h
//  PMCtrl_iPad
//
//  Created by 张姝枫 on 2018/5/18.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BD_FormTBViewBaseModel;
@interface BD_ReprotFormView : UITableView
//@property(nonatomic,strong)NSArray<UILabel *> *formArr1;
//@property(nonatomic,strong)NSArray<UILabel *> *formArr2;
//- (instancetype)initWithNum:(int)num;
@property(nonatomic,strong)NSArray<NSArray<NSString *> *> *headerTitles;
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style headerTitles:(NSArray *)headerTitles;
@property(nonatomic,strong)NSArray<NSArray<BD_FormTBViewBaseModel *> *> *formDatasource;
@end
