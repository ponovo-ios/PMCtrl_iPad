//
//  BD_FormTBViewHeaderView.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/21.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BD_FormTBViewHeaderView : UIView
@property(nonatomic,strong)NSArray<UILabel *> *formArr;
- (instancetype)initWithNum:(int)num;
@end
