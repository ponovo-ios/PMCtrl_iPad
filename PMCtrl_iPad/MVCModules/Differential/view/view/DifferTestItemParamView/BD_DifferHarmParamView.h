//
//  BD_DifferHarmParamView.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/11.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BD_DifferentialTestItemParaModel;

@interface BD_DifferHarmParamView : UIView
@property (weak, nonatomic) IBOutlet UITextField *testItemName;
@property (weak, nonatomic) IBOutlet UIButton *testItemM;
@property (weak, nonatomic) IBOutlet UITextField *testItemFrequency;
@property (weak, nonatomic) IBOutlet UIButton *harmNum;
@property (weak, nonatomic) IBOutlet UITextField *testItemPrecision;
@property (weak, nonatomic) IBOutlet UITextField *testItemId;
@property (weak, nonatomic) IBOutlet UILabel *testItemIdLabel;

@property (weak, nonatomic) IBOutlet UITextField *testItemSearchStartValue;
@property (weak, nonatomic) IBOutlet UITextField *testItemSearchEndValue;

@property (nonatomic,strong)BD_DifferentialTestItemParaModel *viewData;
@property(nonatomic,strong)void(^changeHarmNumBlock)();


-(void)setDataToHarmView;

@end
