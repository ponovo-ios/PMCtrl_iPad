//
//  BD_StateTemplateFileManager.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/5/3.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BD_StateTemplateFileManager : NSObject
/**
 保存模版文件
 @pragma testListDatas 测试项数据，包含输出数据，触发条件等
 @pragma comparam 通用参数
 @pragma deviceGPSTime 测试仪gps数据
 */
-(bool)saveTemplateFile:(NSArray<BD_TestDataParamModel *> * _Nonnull )testListDatas commonPara:(BD_StateTestCommonParamModel * _Nonnull)comparam deviceGPSTime:(BD_UtcTime * _Nonnull)deviceGPSTime fileName:(NSString *_Nullable)fileName;
/**读取模版文件数据
 @return 字典，通用参数和测试项数据通过一个字典全部返回
 */
-(NSMutableArray * _Nullable)readTemplateFileWithfileName:(NSString *_Nullable)fileName;
@end
