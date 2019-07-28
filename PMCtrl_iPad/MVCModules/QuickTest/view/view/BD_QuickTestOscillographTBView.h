//
//  BD_QuickTestOscillographTBView.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/18.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BD_QuickTestOscillographModel.h"
#import "BD_BinaryStateModel.h"
#import "BD_OutputwaveShapeDataModel.h"
@protocol BD_QuickTestGetOscillographDataDelegate<NSObject>
@optional



@required
-(void)refreshData;

@end

/**6U 6I 实时电压电流变化波形图*/
@interface BD_QuickTestOscillographTBView : UIView
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray<BD_QuickTestOscillographModel *> * lineDataSourceArr;
@property (nonatomic,strong)NSArray<NSMutableArray<NSNumber*> *>  *binaryStates;
@property(nonatomic,strong)NSMutableArray<BD_OutputwaveShapeDataModel *> *selectedDataArr;
@property(nonatomic,strong)NSMutableArray<NSMutableArray<NSString *> *>*titleArr;
@property (nonatomic,strong)NSArray<NSArray*> *xValues;
@property(nonatomic,weak)id<BD_QuickTestGetOscillographDataDelegate> dataDelegate;
@property(nonatomic,assign) bool isBegin;
@property(nonatomic,assign)bool isLock;
@property(nonatomic,assign)NSInteger xvalueMax;
//@property(nonatomic,strong)NSTimer *timer;


@end
