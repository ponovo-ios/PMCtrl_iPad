//
//  BD_VectorDiagramListVC.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/6/14.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BD_QuickTestVectorgraphTBView;
/**列表式矢量图*/
@interface BD_VectorDiagramListVC : UIViewController

@property(nonatomic,strong)NSMutableArray *voltageDataArr;
@property(nonatomic,strong)NSMutableArray *currentDataArr;

//刷新页面数据
-(void)refreshViewData;
//清空选择状态数据
-(void)cleanVectorgraphSelectedArr;
@end
