//
//  BD_DifferentialTemplateFileManager.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/5/3.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BD_TestBinarySwitchSetModel;
@class BD_DifferGeneralSetDataModel;
@class BD_DifferSetDataModel;

@interface BD_DifferentialTemplateFileManager : NSObject
/**保存模版文件
 @pragma generalParam 通用参数
 @pragma setParam 整定值
 @pragma binarySwitch 开关量参数
 @pragma testItem 测试项数据
 @pragma outputType 测试仪输出类型 数字／模拟／数模一体
 */
-(bool)saveTemplateFileWithGeneralParam:(BD_DifferGeneralSetDataModel * _Nonnull)generalParam setParam:(BD_DifferSetDataModel * _Nonnull)setParam binarySwitch:(BD_TestBinarySwitchSetModel * _Nonnull)binarySwitch testItem:(NSArray * _Nonnull)testItem outputType:(BDDeviceType)outputType fileName:(NSString *_Nonnull)fileName;
/**
 读取模版文件
 @return 差动试验，将所有参数通过字典一次性返回
 */
-(NSMutableArray * _Nullable)readTemplateFileWithfileName:(NSString *_Nullable)fileName;
@end
