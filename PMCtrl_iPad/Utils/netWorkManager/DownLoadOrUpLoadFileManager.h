//
//  DownLoadOrUpLoadFileManager.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/3.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef NS_ENUM(NSInteger,DownFileType){
    DownFileType_SCD = 0,
};
@interface DownLoadOrUpLoadFileManager : NSObject

/**
 *单例
 */
+ (instancetype)getInstance;


/** AFNetworking断点下载（支持离线）需用到的属性 **********/
/** 文件的总长度 */
@property (nonatomic, assign) NSInteger fileLength;
/** 当前下载长度 */
@property (nonatomic, assign) NSInteger currentLength;
/** 文件句柄对象 */
@property (nonatomic, strong) NSFileHandle *fileHandle;

/** 下载任务 */
@property (nonatomic, strong) NSURLSessionDataTask *downloadTask;
/* AFURLSessionManager */
@property (nonatomic, strong) AFURLSessionManager *manager;

/**
 *
 *自动下载 不能暂停
 @param url  服务端下载地址
 @param filePath 本地存储的沙盒地址
 @param completeProgress  返回下载进度 totalUnitCount completedUnitCount
 */

-(void)autoDownloadTaskWithURL:(NSString *)url filePath:(NSURL *)filePath completeProgress:(void(^)(NSProgress *))completeProgress;
/**
 *
 *开始下载任务
 @param webUrl 服务端下载地址
 @param filePath 本地要存入的沙盒地址
 @param complete 当前进度，总长度
 @return 下载任务对象
 */

-(NSURLSessionDataTask *)startDownTaskWithWebUrl:(NSString *)webUrl filePath:(NSString *)filePath complete:(void(^)(NSInteger,NSInteger))complete;
/**
 *  下载暂停
 */
- (void)downLoadPause;

/**
 *  下载继续
 */
- (void)downLoadResume;

/**
 * 获取已下载的文件大小
 */
- (NSInteger)fileLengthForPath:(NSString *)path;

@end
