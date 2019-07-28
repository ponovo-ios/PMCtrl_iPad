//
//  BD_HarmItem.h
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/12/5.
//  Copyright © 2017年 ponovo. All rights reserved.
//  数据每块模型

#import <Foundation/Foundation.h>

@interface BD_HarmItem : NSObject

/**含有率*/
@property (nonatomic, copy) NSString *containingRate;
/**有效值*/
@property (nonatomic, copy) NSString *validValues;
/**相位*/
@property (nonatomic, copy) NSString *phase;

@end
