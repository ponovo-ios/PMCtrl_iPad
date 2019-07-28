//
//  BD_PickerButton.h
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/11/30.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BD_PickerButton : UIButton

-(void)showPickerViewWithDataArray:(NSArray<NSString *> *)dataArray completion:(void(^)(NSString *title))completion;

@end
