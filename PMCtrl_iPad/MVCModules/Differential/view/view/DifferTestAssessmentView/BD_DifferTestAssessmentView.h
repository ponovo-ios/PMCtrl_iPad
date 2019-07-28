//
//  BD_DifferTestAssessmentView.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/11.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BD_DifferAssessmentModel;
@interface BD_DifferTestAssessmentView : UIView
@property(nonatomic,strong)UIScrollView *itemParamSCview;


@property(nonatomic,strong)void(^QDerrorValueChangedBlock)(NSString *);
-(void)testItemAssessmenViewWithIndex:(NSInteger)index;

/**启动电流／比率制动系数／速断点六评估页面刷新数据*/
-(void)setDataToQDAssessmentViewWithError:(NSString *)error Ir:(NSString *)Ir Id_QD_SD:(NSString *)Id_QD_SD rate:(NSString *)rate rateLabel:(NSString *)rateLabel itemType:(DifferTestItemType)itemType;
/**谐波制动系数评估刷新页面数据*/
-(void)setDataToHarmAssessmentViewWithData:(BD_DifferAssessmentModel *)viewData;
/**动作时间评估刷新页面数据*/
-(void)setDataToActionTimeAssessmentViewWithData:(BD_DifferAssessmentModel *)viewData;
@end
