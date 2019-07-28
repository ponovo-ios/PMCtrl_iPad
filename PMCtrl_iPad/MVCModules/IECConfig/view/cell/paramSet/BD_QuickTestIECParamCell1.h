//
//  BD_QuickTestIECParamCell1.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/13.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
//@protocol BD_QuickTestIECParamBtnDelegate<NSObject>
//
//@optional
//@required
//-(void)valueBtn1Click;
//-(void)valueBtn2Click;
//@end

/**
 *IEC设置  第一种cell 设置额定线电压 额定频率
 */

@interface BD_QuickTestIECParamCell1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title1;
@property (weak, nonatomic) IBOutlet UILabel *title2;
@property (weak, nonatomic) IBOutlet UITextField *value1;
@property (weak, nonatomic) IBOutlet UITextField *value2;
@property (weak, nonatomic) IBOutlet UIButton *valueBtn1;
@property (weak, nonatomic) IBOutlet UIButton *valueBtn2;
@property (weak, nonatomic) IBOutlet UILabel *unit1;
@property (weak, nonatomic) IBOutlet UILabel *unit2;

//@property (nonatomic,weak)id<BD_QuickTestIECParamBtnDelegate> delegate;
@property (nonatomic,strong)void(^value1BtnClickBlock)(UITextField *);
@property (nonatomic,strong)void(^value2BtnClickBlock)(UITextField *);
@end
