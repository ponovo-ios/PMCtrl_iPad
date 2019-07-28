//
//  BD_StateTestItemModel.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/25.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BD_StateTestParamModel;
@interface BD_StateTestItemModel : NSObject<NSCopying,NSMutableCopying>
@property(nonatomic,assign)NSInteger itemNum;
@property(nonatomic,strong)NSString *itemName;
@property(nonatomic,strong)NSString *itemProject;
@property(nonatomic,assign)BOOL itemSelect;
@property(nonatomic,strong)NSString *itemResult;
@property(nonatomic,strong)BD_StateTestParamModel *itemParam;
@end
