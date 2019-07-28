//
//  BD_DifferGooseSendView.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/11.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BD_DifferGooseSendView : UIView
@property(nonatomic,assign)NSInteger groupNum;
@property(nonatomic,strong)NSArray<UIButton *> *viewTabArr;
-(void)loadSubViews;
@end
