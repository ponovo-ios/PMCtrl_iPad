//
//  BD_OutputwaveShapeTBView.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/28.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BD_OutputwaveShapeDataModel.h"


@protocol BD_OutputwaveShapeAutoRefreshDataDelegate<NSObject>

@required
-(void)refreshOutputwaveData;
@optional 

@end

@interface BD_OutputwaveShapeTBView : UITableView

//数据源 波形图数组形式
@property(nonatomic,strong)NSArray<BD_OutputwaveShapeDataModel *> *dataArr;
@property(nonatomic,strong)NSMutableArray<BD_OutputwaveShapeDataModel *> *selecteddataArr;
@property(nonatomic,strong)NSTimer *waveTimer;
@property(nonatomic,assign)id<BD_OutputwaveShapeAutoRefreshDataDelegate> wavedelegate;
@property(nonatomic,assign)BOOL hasShowWaveImage;

-(void)startTimer;
-(void)stopTimer;
-(void)createTimer;
-(void)cancelTimer;


@end
