//
//  FileUtil.m
//  AFNetworkingDownloadTest
//
//  Created by YNKJMACMINI2 on 15/10/22.
//  Copyright © 2015年 YNKJMACMINI2. All rights reserved.
//

#import "FileUtil.h"

@implementation FileUtil

//获取Documents目录
+(NSString *)documentsPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

//创建目录
+(BOOL)createDirectoryWithPath:(NSString *)directoryPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //创建目录
    BOOL res=[fileManager createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
    if (res)
    {
        NSLog(@"目录创建成功：%@",directoryPath);
    }else
    {
        NSLog(@"目录创建失败：%@",directoryPath);
    }
    return res;
}

//创建文件
+(BOOL)createFileWithPath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL res=[fileManager createFileAtPath:filePath contents:nil attributes:nil];
    if (res) {
        NSLog(@"文件创建成功: %@" ,filePath);
    }else
        NSLog(@"文件创建失败: %@" ,filePath);
    return res;
}
//创建文件
+(NSString *)createFileWithFileName:(NSString *)fileName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [[self documentsPath] stringByAppendingString:fileName];
    BOOL res=[fileManager createFileAtPath:filePath contents:nil attributes:nil];
    if (res) {
        NSLog(@"文件创建成功: %@" ,filePath);
    }else
        NSLog(@"文件创建失败: %@" ,filePath);
    return filePath;
}

//删除文件
+(BOOL)deleteFileWithPath:(NSString *)plistName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
 
    //清除plist文件，可以根据我上面讲的方式进去本地查看plist文件是否被清除
   
    NSString *plistPath1 = [self documentsPath];
    NSString *filename=[plistPath1 stringByAppendingPathComponent:plistName];
    
    // 如果文件路径存在的话
    BOOL bRet = [self existFileAtPath:filename];
    if (bRet) {
        NSError *err;
        BOOL res = [fileManager removeItemAtPath:filename error:&err];
        if (res) {
            NSLog(@"文件删除成功: %@",filename);
        }else {
            NSLog(@"文件删除失败: %@",filename);
        }
        return res;
    }
    return YES;
}

//文件是否存在
+(BOOL)existFileAtPath:(NSString *)filePath
{
    NSFileManager * fileManager=[NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:filePath];
}

+(void)createPlistFile:(NSString *)plistName{
    
    NSString *plistPath1 = [self documentsPath];
    
    NSString *filename=[plistPath1 stringByAppendingPathComponent:plistName];
   BOOL suc  = [self createFileWithPath:filename];
    //输入写入
    if (suc) {
        NSLog(@"创建plist文件成功");
    } else{
        NSLog(@"创建plist文件失败");
    }
    NSLog(@"fileName:%@",filename);
   
    
    
}

+(NSArray *)getDirectoryFileNames:(NSString *)DirectoryName{
    NSString *documentsPath = [self documentsPath];
    NSFileManager * fileManager=[NSFileManager defaultManager];
    
 NSArray *names = [fileManager contentsOfDirectoryAtPath:[documentsPath stringByAppendingString:DirectoryName] error:nil];
    
    return names;
}
+(NSString *)readInfoFilePath:(NSString *)plistName{
    
    NSString *plistPath1 = [self documentsPath];
    NSString *filename=[plistPath1 stringByAppendingPathComponent:plistName];
    
    NSLog(@"%@",filename);
    return filename;
}

+(void)saveInfoToPlist:(NSString *)plistName dic:(NSDictionary *)dic{
    
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    
    NSString *filename=[plistPath1 stringByAppendingPathComponent:plistName];
    //输入写入
    NSLog(@"fileName:%@",filename);
    [dic writeToFile:filename atomically:YES];
    
    
 
}

+(NSDictionary *)readInfoFromPlist:(NSString *)plistName{
   
    NSString *plistPath1 = [self documentsPath];
    NSString *filename=[plistPath1 stringByAppendingPathComponent:plistName];
    NSDictionary *infodic = [[NSDictionary alloc] initWithContentsOfFile:filename];
   
    NSLog(@"%@", infodic);
    return infodic;
}
+(bool)delateAllTemplateFiles{
    NSError *error;
    NSFileManager *manager = [[NSFileManager alloc]init];
    NSArray *fileNames = [self getDirectoryFileNames:@""];
    NSString *path = [self documentsPath];
    
    for (NSString *fileName in fileNames) {
        
        if ([[fileName substringFromIndex:fileName.length-3] isEqualToString:@"ies"]) {
            NSString *filepath = [path stringByAppendingPathComponent:fileName];
            [manager removeItemAtPath:filepath error:&error];
            if (!error) {
                continue;
            } else {
                return NO;
                break;
            }
        }
        
    }
    return YES;
}
+(bool)writeDataToFileName:(NSString *)fileName data:(NSData *)dataChar{
    NSError *error;
    NSString *plistPath1 = [self documentsPath];
    NSString *filepath=[plistPath1 stringByAppendingPathComponent:fileName];
    if ([self existFileAtPath:filepath]) {
        NSFileManager *filemanager = [[NSFileManager alloc]init];
        [filemanager removeItemAtPath:filepath error:&error];
        if (!error) {
            [dataChar writeToFile:filepath atomically:YES];
            return true;
        } else {
            return false;
        }
       
    } else {
        if ([self createFileWithPath:filepath]) {
             [dataChar writeToFile:filepath atomically:YES];
            return true;
        }
    }
    NSLog(@"filename:%@",filepath);
    return true;
}


+(NSData *)readDataToFileName:(NSString *)fileName{
    NSData *fileData;
    NSString *plistPath1 = [self documentsPath];
    NSString *filepath=[plistPath1 stringByAppendingPathComponent:fileName];
    if ([self existFileAtPath:filepath]) {
        fileData = [NSData dataWithContentsOfFile:filepath];
    } else {
        DLog(@"文件不存在")
    }
    NSLog(@"fileData:%@",fileData);
    return fileData;
}

@end
