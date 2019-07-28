//
//  BD_IECSMVSCLFormHeaderView.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/8.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BD_IECSMVSCLFormHeaderView : UIView

/**根据headerView的title数组创建headerView*/
-(instancetype)initWithTitls:(NSArray *)titleArr viewWidth:(CGFloat)viewWidth;

@property(nonatomic,strong)NSArray *headerTitles;
@property(nonatomic,assign)CGFloat viewWidth;
@end

