//
//  BD_DifferQDCurrentAssessmentView.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/12.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BD_DifferQDCurrentAssessmentView : UIView
@property(nonatomic,assign)DifferTestItemType testType;
@property (weak, nonatomic) IBOutlet UILabel *IrResultLabel;
@property (weak, nonatomic) IBOutlet UITextField *IrResult;
@property (weak, nonatomic) IBOutlet UITextField *QdResult;
@property (weak, nonatomic) IBOutlet UILabel *QdResultLabel;
@property (weak, nonatomic) IBOutlet UITextField *error;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UITextField *rate;

@property(nonatomic,strong)void(^errorValueChangedBlock)(NSString *);
//设置页面数据
-(void)setViewDataWithError:(NSString *)error Ir:(NSString *)Ir Id_QD_SD:(NSString *)Id_QD_SD rate:(NSString *)rate rateLabel:(NSString *)rateLabel;
@end
