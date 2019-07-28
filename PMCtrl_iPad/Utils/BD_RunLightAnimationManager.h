//
//  BD_RunLightAnimationManager.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/6/6.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface BD_RunLightAnimationManager : NSObject
@property(nonatomic,strong)UIView *changeView;
-(instancetype)initWithView:(UIView *)view;
-(void)stopflashView;
@end
