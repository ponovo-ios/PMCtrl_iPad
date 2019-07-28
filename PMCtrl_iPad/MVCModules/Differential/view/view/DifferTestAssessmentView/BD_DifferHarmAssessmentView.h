//
//  BD_DifferHarmAssessmentView.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/12.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BD_DifferAssessmentModel;

@interface BD_DifferHarmAssessmentView : UIView
@property (weak, nonatomic) IBOutlet UIButton *absoluteErrorBtn;
@property (weak, nonatomic) IBOutlet UITextField *absoluteError;
@property (weak, nonatomic) IBOutlet UIButton *relativeErrorBtn;
@property (weak, nonatomic) IBOutlet UITextField *relativeError;
@property (weak, nonatomic) IBOutlet UITextField *expression;
@property (weak, nonatomic) IBOutlet UITextField *IdResult;
@property (weak, nonatomic) IBOutlet UILabel *IdResultLabel;
@property (weak, nonatomic) IBOutlet UILabel *IrResultLabel;
@property (weak, nonatomic) IBOutlet UITextField *IrResult;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UITextField *rate;

@property(nonatomic,strong)BD_DifferAssessmentModel *viewData;
-(void)setViewData;
@end
