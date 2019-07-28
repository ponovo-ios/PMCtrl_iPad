//
//  BD_DirectCurrentSetManager.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/11.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BD_DirectCurrentSetManager : NSObject
@property(nonatomic,assign)CGFloat dcCurrentMax;
@property(nonatomic,assign)CGFloat dcCurrentValue;
-(instancetype)initWithVC:(UIViewController *)vc;
-(void)showDirectCurrentView;
@end
