//
//  BD_VectorDiagramVC.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/11.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BD_TestDataParamModel;
/**翻页式矢量图*/
@interface BD_VectorDiagramVC : UIViewController
@property(nonatomic,strong)NSArray<NSArray *> *baseHeaderTitles;
/**矢量图数据源，分别表示各个分页的数据
  每个分页表示一组数据，每组数据是一个数组
 
 */
@property(nonatomic,strong)NSMutableArray<NSMutableArray<BD_TestDataParamModel *> *> *vectorDataSource;
/**刷新矢量图数据*/
-(void)updateSubViews;
@end
