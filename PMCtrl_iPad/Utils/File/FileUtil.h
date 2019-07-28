//
//  FileUtil.h
//  AFNetworkingDownloadTest
//
//  Created by YNKJMACMINI2 on 15/10/22.
//  Copyright © 2015年 YNKJMACMINI2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileUtil : NSObject

//获取沙盒Documents文件夹路径
+(NSString *)documentsPath;
//创建目录，若父目录不存在则会连同父目录一起创建
+(BOOL)createDirectoryWithPath:(NSString *)directoryPath;
//创建文件，若文件已经存在则返回YES，若不存在则创建文件，创建成功返回YES，创建失败返回NO
+(BOOL)createFileWithPath:(NSString *)filePath;
//根据名称创建文件
+(NSString *)createFileWithFileName:(NSString *)fileName;
//读取文件地址
+(NSString *)readInfoFilePath:(NSString *)plistName;
//获取文件夹中的文件名
+(NSArray *)getDirectoryFileNames:(NSString *)DirectoryName;
//文件是否存在
+(BOOL)existFileAtPath:(NSString *)filePath;
//删除文件，若删除成功 或 文件不存在，则返回YES，否则返回NO
+(BOOL)deleteFileWithPath:(NSString *)plistName;
/**删除沙盒中的全部模版*/
+(bool)delateAllTemplateFiles;
//保存数据到plist文件中
+(void)saveInfoToPlist:(NSString *)plistName dic:(NSDictionary *)dic;
/**
//获取plist文件中的数据
 paramer plistName  plist文件名称
*/
+(NSDictionary *)readInfoFromPlist:(NSString *)plistName;
/**将二进制数据写入文件中*/
+(bool)writeDataToFileName:(NSString *)fileName data:(NSData *)dataChar;
/**读取文件中的二进制数*/
+(NSData *)readDataToFileName:(NSString *)fileName;
@end
