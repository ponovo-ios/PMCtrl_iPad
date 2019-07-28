//
//  BD_InformationHeaderView.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/2/6.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BD_InformationHeaderView : UIView
/**
 根据传入的headerView的item标题初始化
 @parama titles 标题数组
 */
-(instancetype)initWithTitles:(NSArray *)titles;

-(void)loadViews;
@end
