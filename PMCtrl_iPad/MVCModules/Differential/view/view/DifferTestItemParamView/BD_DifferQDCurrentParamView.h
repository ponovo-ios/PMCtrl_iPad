//
//  BD_DifferQDCurrentParamView.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/11.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BD_DifferentialTestItemParaModel;
@interface BD_DifferQDCurrentParamView : UIView
@property (weak, nonatomic) IBOutlet UITextField *testItemName;
@property (weak, nonatomic) IBOutlet UIButton *testItemM;
@property (weak, nonatomic) IBOutlet UITextField *testItemFrequency;
@property (weak, nonatomic) IBOutlet UIButton *testItemType;
@property (weak, nonatomic) IBOutlet UITextField *testItemPrecision;
@property (weak, nonatomic) IBOutlet UILabel *testItemPrecisionLabel;

@property (weak, nonatomic) IBOutlet UITextField *testItemIr;
@property (weak, nonatomic) IBOutlet UITextField *testItemUp;
@property (weak, nonatomic) IBOutlet UITextField *testItemDown;
@property (weak, nonatomic) IBOutlet UILabel *testItemIrLabel;
@property (weak, nonatomic) IBOutlet UILabel *testItemUpLabel;
@property (weak, nonatomic) IBOutlet UILabel *testItemDownLabel;


@property (nonatomic,strong)BD_DifferentialTestItemParaModel *viewData;

-(void)setDataToQDCurrentView;
@end
