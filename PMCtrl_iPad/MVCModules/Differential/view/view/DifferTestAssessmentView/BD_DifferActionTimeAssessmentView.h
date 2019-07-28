//
//  BD_DifferActionTimeAssessmentView.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/12.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BD_DifferAssessmentModel;
@interface BD_DifferActionTimeAssessmentView : UIView
@property (weak, nonatomic) IBOutlet UIButton *relativeErrorBtn;
@property (weak, nonatomic) IBOutlet UITextField *relativeValue;
@property (weak, nonatomic) IBOutlet UIButton *errorLogicBtn;
@property (weak, nonatomic) IBOutlet UIButton *absoluteErrorBtn;
@property (weak, nonatomic) IBOutlet UITextField *absoluteValue;
@property (weak, nonatomic) IBOutlet UITextField *expressionValue;
@property (weak, nonatomic) IBOutlet UILabel *IdResultLabel;
@property (weak, nonatomic) IBOutlet UITextField *IdResult;
@property (weak, nonatomic) IBOutlet UILabel *IrResultLabel;
@property (weak, nonatomic) IBOutlet UITextField *IrResult;
@property (weak, nonatomic) IBOutlet UITextField *actionTimeValue;

-(void)setViewData;
@property(nonatomic,strong)BD_DifferAssessmentModel *viewData;
@end
