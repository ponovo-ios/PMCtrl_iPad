//
//  BD_OutputwaveShapeCell.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/28.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BD_OutputwaveShapeDataModel.h"
#import "PMCtrl_iPad-Swift.h"
#import "PMCtrl_iPad-Bridging-Header.h"
@interface BD_OutputwaveShapeCell : UITableViewCell

/** 波形图data数据源 幅值 相位 */
@property(nonatomic,strong)BD_OutputwaveShapeDataModel *waveDataModel;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**输出实时波形图*/
@property (weak, nonatomic) IBOutlet LineChartView *waveShapeView;

@property (weak, nonatomic) IBOutlet UILabel *UVLabel;
@property (weak, nonatomic) IBOutlet UILabel *IALabel;
@property(nonatomic,assign) BOOL isShowLinewave;
@property(nonatomic,strong)NSMutableArray *voltageSelectedArr;
@property(nonatomic,strong)NSMutableArray *currentSelectedArr;
@property(nonatomic,strong)void((^selectedWaveShapeViewBlock)(NSMutableArray *,NSMutableArray *));

@end
