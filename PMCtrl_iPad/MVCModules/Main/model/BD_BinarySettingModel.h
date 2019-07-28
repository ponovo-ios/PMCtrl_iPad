//
//  BD_BinarySettingModel.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/12.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BD_BinarySettingModel:NSObject<NSCopying,NSMutableCopying>
@property(nonatomic,strong)NSString *title ;
@property(nonatomic,assign)BOOL isBlankNode;
@property(nonatomic,strong)NSString *rolloverValue;

@end
