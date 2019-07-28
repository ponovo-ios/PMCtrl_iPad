//
//  BD_HarmDataTableView.h
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/12/1.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BD_HarmModel.h"

@interface BD_HarmDataTableView : UITableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style tableModel:(BD_HarmTableDataModel *)tableModel;

/**谐波模型*/
@property (nonatomic, strong) BD_HarmModel *harmModel;
/**表数据模型*/
@property (nonatomic, weak) BD_HarmTableDataModel *tableModel;
//全选
-(void)selectAllCell;

//全不选
-(void)deSelectAllCell;
//刷新页面数据
-(void)updateDataView;

@end
