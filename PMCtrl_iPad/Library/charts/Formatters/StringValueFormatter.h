//
//  StringValueFormatter.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/7/12.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMCtrl_iPad-Swift.h"
@interface StringValueFormatter : NSObject<IChartAxisValueFormatter>
- (id)initWithArr:(NSArray *)arr;
@end
