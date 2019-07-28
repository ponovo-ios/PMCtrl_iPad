//
//  BD_TestItemParamModel.h
//  PMCtrl_iPad
//
//  Created by 张姝枫 on 2018/6/1.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BD_TestItemParamModel : NSObject<NSCopying,NSMutableCopying>
@property(nonatomic,assign)NSInteger itemNum;
@property(nonatomic,assign)NSString *itemName;
@property(nonatomic,strong)NSString *itemProject;
@property(nonatomic,assign)BOOL itemSelect;
@property(nonatomic,strong)NSString *itemResult;
@end
