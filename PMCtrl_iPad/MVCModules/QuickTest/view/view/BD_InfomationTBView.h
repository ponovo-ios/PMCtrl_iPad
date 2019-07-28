//
//  BD_InfomationTBView.h
//  PMCtrl_iPad
//
//  Created by 张姝枫 on 2018/1/30.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BD_TestInformationModel.h"
@interface BD_InfomationTBView : UITableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style headerTitles:(NSArray *)headerTitles;

@property(nonatomic,strong)NSMutableArray<BD_TestInformationModel *>  *infoDataSource;
@property(nonatomic,assign)BOOL isScrollTBView;
-(void)createFalsedata;
@end
