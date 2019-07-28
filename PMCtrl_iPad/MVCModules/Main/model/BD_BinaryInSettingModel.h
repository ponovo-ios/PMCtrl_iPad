//
//  BD_BinaryInSettingModel.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/12.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BD_BinaryInSettingModel:NSObject<NSCopying,NSMutableCopying>
@property(nonatomic,strong)NSString *title ;
@property(nonatomic,assign)BOOL isBlankNode;
@property(nonatomic,strong)NSString *rolloverValue;

@end


@interface BD_BinaryInSetData:NSObject<NSCopying,NSMutableCopying>
/**开入模式*/
@property(nonatomic,assign)int binaryStyle;//0--开入量模式。1--采集模式
/**开入量信息列表*/
@property(nonatomic,strong)NSMutableArray<BD_BinaryInSettingModel *> *binaryInfoList;
/**开入防抖时间*/
@property(nonatomic,assign)int bitime;
@end
