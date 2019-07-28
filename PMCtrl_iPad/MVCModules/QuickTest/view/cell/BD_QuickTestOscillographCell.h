//
//  BD_QuickTestOscillographCell.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/18.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMCtrl_iPad-Swift.h"
#import "PMCtrl_iPad-Bridging-Header.h"
#import "BD_QuickTestOscillographModel.h"
/**6U 6I 实时电压电流变化cell*/
@protocol BD_OscillographViewRefreshDelegate<NSObject>
@required
-(void)getRealData:(void(^)())complete;

@end

@interface BD_QuickTestOscillographCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet LineChartView *lineChartView;
@property (nonatomic,strong)NSArray<NSString *> *titleArr;

@property (nonatomic,strong)NSMutableArray *timeArr;
@property(nonatomic,assign) bool isBegin;
@property (nonatomic,strong)NSMutableArray<BD_QuickTestOscillographModel_Base *> *voltageDataArr;
@property (nonatomic,strong)NSMutableArray<BD_QuickTestOscillographModel_Base *> *currentDataArr;
@property(nonatomic,assign)int chartViewXMax;
@property (nonatomic,strong)NSMutableArray *voltageSelectedArr;
@property (nonatomic,strong)NSMutableArray *currentSelectedArr;
@property (nonatomic,strong)void(^cellLineStateBlock)(NSMutableArray *,NSMutableArray *);
@property(nonatomic,strong)id<BD_OscillographViewRefreshDelegate> delegate;
//@property (nonatomic,strong)void(^getDataFromVCBlock)();
-(void)setCellData;
-(void)createSelectedView;
@end
