//
//  BD_DifferAddSeriesView.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/20.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BD_DifferAddSeriesView : UIView
@property(nonatomic,strong)void(^okActionBlock)(float,float,float,int);

-(void)showAddSeriesView;
@end
