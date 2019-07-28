//
//  BD_HarmTemplateFileManager.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/5/3.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BD_HarmModel;
@interface BD_HarmTemplateFileManager : NSObject
/**保存模版文件
 @pragma model 谐波试验参数
 */
-(bool)saveTemplateFile:( BD_HarmModel * _Nonnull )model fileName:(NSString *_Nonnull)fileName;
/**
 读取模版文件
 @return 工程中对应的谐波试验参数
 */
-(BD_HarmModel * _Nullable)readTemplateFileWithfileName:(NSString *_Nullable)fileName;
@end
