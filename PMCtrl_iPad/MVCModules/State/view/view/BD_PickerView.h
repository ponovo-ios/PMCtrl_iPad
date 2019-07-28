//
//  BD_PickerView.h
//  PMCtrl_iPad
//
//  Created by 张姝枫 on 2018/1/7.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BD_PickerView : UIView
@property(nonatomic,strong)UIPickerView *datePickerView;
@property(nonatomic,strong)NSArray *hours;
@property(nonatomic,strong)NSArray *minutes;
@property(nonatomic,strong)NSArray *seconds;
@end
