//
//  BD_UtcTime.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/27.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BD_UtcTime : NSObject

@property(nonatomic,assign)int year;
@property(nonatomic,assign)int month;
@property(nonatomic,assign)int day;
@property(nonatomic,assign)int hour;
@property(nonatomic,assign)int minute;
@property(nonatomic,assign)int second;
@property(nonatomic,assign)int millisecond;

@end
