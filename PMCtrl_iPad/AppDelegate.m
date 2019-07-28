//
//  AppDelegate.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/9/29.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "AppDelegate.h"
#import "BD_BaseNavigationVC.h"
#import "BD_DeviceInfoService.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [self loadWindowRootView];
    
//    //程序启动，在沙盒中创建scd文件夹
    //判断沙盒document中，是否有scd文件
    NSString *filePath = [FileUtil documentsPath];
    DLog(@"沙盒路径:%@",filePath);
    if (![BD_DeviceInfoService shared].timer) {
        [[BD_DeviceInfoService shared] createTimer];
    }
//    //判断是否有SCDFiles文件夹，如果没有，创建文件夹
//    if (![FileUtil existFileAtPath:filePath]) {
////        [FileUtil createDirectoryWithPath:[[FileUtil documentsPath] stringByAppendingString:@"/SCDFiles"]];
//    }
    
    
//    NSString *aa = @"";
//    
//    NSData *data = [aa dataUsingEncoding:NSUTF8StringEncoding];
//    
//    Byte *bb = (Byte *)[data bytes];
//    for(NSInteger i=0;i<data.length;i++）{
//        printf（"testByte = ％d "，testByte[i]）;
//    }


//    NSData *data  = [[NSData alloc]init];
//    NSString *datastr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//
//    NSData *dd = [datastr dataUsingEncoding:NSUTF8StringEncoding];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    NSLog(@"EnterBackground");
   

    
    [self removeFiles];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
#pragma mark - 开启服务器段
    dispatch_queue_t serialQueue = dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(serialQueue, ^{
        [[OCCenter shareCenter] serviceRun];
    });
    
//    [self creatFilesForShowResults];
    
    NSLog(@"DidBecomeActive");
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
      NSLog(@"DidBecomeTerminate");
    [self removeFiles];
    [FileUtil deleteFileWithPath:@"generalValue.plist"];
    [FileUtil deleteFileWithPath:@"settingValue.plist"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:BD_KneePointCount];
    [[BD_DeviceInfoService shared] cancelTimer];
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"PMCtrl_iPad"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}


-(void)loadWindowRootView{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [story instantiateViewControllerWithIdentifier:@"BD_LoginVCID"];
    BD_BaseNavigationVC *navi = [[BD_BaseNavigationVC alloc]initWithRootViewController:vc];
    self.window.rootViewController = navi;
}



#pragma mark - 创建文件
- (void)creatFilesForShowResults{
    
    //获取tmp路径
    NSString *tmpPath = NSTemporaryDirectory();
    //    NSLog(@"tmpPath -------  %@",tmpPath);
    
    NSString *dateString = [BD_Utils getCurrentDate];
    
    //文件名
    NSString *manualFileName = [NSString stringWithFormat:@"Manual%@.txt",dateString];
    NSString *stateFileName = [NSString stringWithFormat:@"State%@.txt",dateString];
    NSString *differFileName = [NSString stringWithFormat:@"Differ%@.txt",dateString];
    
    
    //1. 拼接要创建文件的路径,尾缀没有影响
    NSString *manualFilePath = [tmpPath stringByAppendingPathComponent:manualFileName];
    NSString *stateFilePath = [tmpPath stringByAppendingPathComponent:stateFileName];
    NSString *differFilePath = [tmpPath stringByAppendingPathComponent:differFileName];
    
    //保存路径到沙盒中
    [kUserDefaults setValue:manualFilePath forKey:@"manualFilePath"];
    [kUserDefaults setValue:stateFilePath forKey:@"stateFilePath"];
    [kUserDefaults setValue:differFilePath forKey:@"differFilePath"];
    
    //2.创建文件夹
    //参数：文件路径、文件内容、文件的属性
    BOOL sucess = [kFileManager createFileAtPath:stateFilePath contents:nil attributes:nil];
    BOOL sucess1 = [kFileManager createFileAtPath:manualFilePath contents:nil attributes:nil];
    BOOL sucess2 = [kFileManager createFileAtPath:differFilePath contents:nil attributes:nil];
}
#pragma mark - 删除
- (void)removeFiles{
    
    NSString *path1 = [kUserDefaults valueForKey:@"manualFilePath"];
    NSString *path2 = [kUserDefaults valueForKey:@"stateFilePath"];
    NSString *path3 = [kUserDefaults valueForKey:@"differFilePath"];
    [[NSFileManager defaultManager] removeItemAtPath:path1 error:nil];
    [[NSFileManager defaultManager] removeItemAtPath:path2 error:nil];
    [[NSFileManager defaultManager] removeItemAtPath:path3 error:nil];
}


@end
