//
//  BD_ManualTemplateFileManager.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/5/3.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BD_ManualTemplateFileManager : NSObject

/**
 保存模版文件
 @pragma value 手动试验参数，正常数组中应该有3数组， 电压输出值 电流输出值 通用参数
 */
-(bool)saveTemplateFile:(NSArray * _Nonnull)value fileName:(NSString *_Nonnull)fileName;
/**
 读取配置文件
 @return 通过数组将电压输出值 电流输出值 通用参数一起返回
 */
-(NSArray * _Nullable)readTemplateFileWithfileName:(NSString *_Nullable)fileName;
@end
