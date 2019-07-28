//
//  BD_TestItemParamView.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/11.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BD_DifferentialTestItemParaModel;
@class BD_DifferSetDataModel;
@interface BD_TestItemParamView : UIView

@property(nonatomic,strong)UIScrollView *itemParamSCview;
@property(nonatomic,strong)void(^changeHarmNumBlock)();
-(void)testItemParamViewWithIndex:(NSInteger)index;

-(void)setDataToQDCurrentView:(BD_DifferentialTestItemParaModel *)data;
-(void)setDataToHarmView:(BD_DifferentialTestItemParaModel *)data;
-(void)setDataToActionView:(BD_DifferentialTestItemParaModel *)data;
@end
