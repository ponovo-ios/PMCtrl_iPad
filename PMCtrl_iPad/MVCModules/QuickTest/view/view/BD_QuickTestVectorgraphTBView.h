//
//  BD_QuickTestVectorgraphTBView.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/17.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BD_QuickTestVactorgraphModel;
@interface BD_QuickTestVectorgraphTBView : UITableView
@property(nonatomic,strong) NSMutableArray *selectedDataArr;
@property(nonatomic,strong)NSMutableArray <BD_QuickTestVactorgraphModel *> *drawViewDataSource;
-(void)createCellSelectedArr;
@end
