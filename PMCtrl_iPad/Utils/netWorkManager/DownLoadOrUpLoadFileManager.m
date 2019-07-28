//
//  DownLoadOrUpLoadFileManager.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/3.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "DownLoadOrUpLoadFileManager.h"

@implementation DownLoadOrUpLoadFileManager


+ (instancetype)getInstance
{
    static DownLoadOrUpLoadFileManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DownLoadOrUpLoadFileManager alloc]init];
    });
    return manager;
}
-(void)autoDownloadTaskWithURL:(NSString *)url filePath:(NSURL *)filePath completeProgress:(void(^)(NSProgress *))completeProgress{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    // 1. 创建会话管理者
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    // 2. 创建下载路径和请求对象
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    // 3.创建下载任务
    /**
     * 第一个参数 - request：请求对象
     * 第二个参数 - progress：下载进度block
     *      其中： downloadProgress.completedUnitCount：已经完成的大小
     *            downloadProgress.totalUnitCount：文件的总大小
     * 第三个参数 - destination：自动完成文件剪切操作
     *      其中： 返回值:该文件应该被剪切到哪里
     *            targetPath：临时路径 tmp NSURL
     *            response：响应头
     * 第四个参数 - completionHandler：下载完成回调
     *      其中： filePath：真实路径 == 第三个参数的返回值
     *            error:错误信息
     */
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress) {
        
        completeProgress(downloadProgress);
    
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
//        NSURL *path = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
//        return [path URLByAppendingPathComponent:@"QQ_V5.4.0.dmg"];
        return filePath;
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
    }];
    
    // 4. 开启下载任务
    [downloadTask resume];
    
}


/**
 * manager的懒加载
 */
- (AFURLSessionManager *)manager {
    if (!_manager) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        // 1. 创建会话管理者
        _manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    }
    return _manager;
}

/**
 * 开始下载数据
 */

-(NSURLSessionDataTask *)startDownTaskWithWebUrl:(NSString *)webUrl filePath:(NSString *)filePath complete:(void(^)(NSInteger,NSInteger))complete{
    
    if (!_downloadTask) {
        // 创建下载URL
        NSURL *url = [NSURL URLWithString:webUrl];
        
        // 2.创建request请求
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        // 设置HTTP请求头中的Range
        NSString *range = [NSString stringWithFormat:@"bytes=%zd-", self.currentLength];
        [request setValue:range forHTTPHeaderField:@"Range"];
        
        __weak typeof(self) weakSelf = self;
        _downloadTask = [self.manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            NSLog(@"dataTaskWithRequest");
            
            // 清空长度
            weakSelf.currentLength = 0;
            weakSelf.fileLength = 0;
            
            // 关闭fileHandle
            [weakSelf.fileHandle closeFile];
            weakSelf.fileHandle = nil;
            
        }];
        
        [self.manager setDataTaskDidReceiveResponseBlock:^NSURLSessionResponseDisposition(NSURLSession * _Nonnull session, NSURLSessionDataTask * _Nonnull dataTask, NSURLResponse * _Nonnull response) {
            NSLog(@"NSURLSessionResponseDisposition");
            
            // 获得下载文件的总长度：请求下载的文件长度 + 当前已经下载的文件长度
            weakSelf.fileLength = response.expectedContentLength + self.currentLength;
            
//            // 沙盒文件路径
//            NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"QQ_V5.4.0.dmg"];
            
            NSLog(@"File downloaded to: %@",filePath);
            
            // 创建一个空的文件到沙盒中
            NSFileManager *manager = [NSFileManager defaultManager];
            
            if (![manager fileExistsAtPath:filePath]) {
                // 如果没有下载文件的话，就创建一个文件。如果有下载文件的话，则不用重新创建(不然会覆盖掉之前的文件)
                [manager createFileAtPath:filePath contents:nil attributes:nil];
            }
            
            // 创建文件句柄
            weakSelf.fileHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
            
            // 允许处理服务器的响应，才会继续接收服务器返回的数据
            return NSURLSessionResponseAllow;
        }];
        
        [self.manager setDataTaskDidReceiveDataBlock:^(NSURLSession * _Nonnull session, NSURLSessionDataTask * _Nonnull dataTask, NSData * _Nonnull data) {
            NSLog(@"setDataTaskDidReceiveDataBlock");
            
            // 指定数据的写入位置 -- 文件内容的最后面
            [weakSelf.fileHandle seekToEndOfFile];
            
            // 向沙盒写入数据
            [weakSelf.fileHandle writeData:data];
            
            // 拼接文件总长度
            weakSelf.currentLength += data.length;
            
            // 获取主线程，不然无法正确显示进度。
            NSOperationQueue* mainQueue = [NSOperationQueue mainQueue];
            [mainQueue addOperationWithBlock:^{
              //回调下载进度
                complete(weakSelf.currentLength,weakSelf.fileLength);
            }];
        }];
    }
   
    return _downloadTask;
}

//暂停下载
-(void)downLoadPause{
        [self.downloadTask suspend];
        self.downloadTask = nil;
}

//继续下载
-(void)downLoadResume{
    // 沙盒文件路径
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"QQ_V5.4.0.dmg"];
    NSInteger currentLength = [self fileLengthForPath:path];
    if (currentLength > 0) {  // [继续下载]
        self.currentLength = currentLength;
    }
    [self.downloadTask resume];
}

//获取文件的大小
- (NSInteger)fileLengthForPath:(NSString *)path {
    NSInteger fileLength = 0;
    NSFileManager *fileManager = [[NSFileManager alloc] init]; // default is not thread safe
    if ([fileManager fileExistsAtPath:path]) {
        NSError *error = nil;
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:path error:&error];
        if (!error && fileDict) {
            fileLength = [fileDict fileSize];
        }
    }
    return fileLength;
}

@end
