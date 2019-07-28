//
//  BD_HarmDataHeaderView.h
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/12/1.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BD_HarmDataHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIView *viewZ;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewZConstraint;

/**标题数组*/
@property (nonatomic, copy) NSArray *titleArray;
@end
