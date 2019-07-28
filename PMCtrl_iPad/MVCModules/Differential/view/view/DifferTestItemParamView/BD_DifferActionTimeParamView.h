//
//  BD_DifferActionTimeParamView.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/11.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BD_DifferentialTestItemParaModel;
@interface BD_DifferActionTimeParamView : UIView
@property (weak, nonatomic) IBOutlet UITextField *testItemName;
@property (weak, nonatomic) IBOutlet UIButton *testItemM;
@property (weak, nonatomic) IBOutlet UITextField *testItemFrequency;
@property (weak, nonatomic) IBOutlet UITextField *testItemid;
@property (weak, nonatomic) IBOutlet UITextField *testItemIr;
@property (weak, nonatomic) IBOutlet UILabel *testItemIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *testItemIrLabel;


@property (nonatomic,strong)BD_DifferentialTestItemParaModel *viewData;
-(void)setDataToActionView;
@end
