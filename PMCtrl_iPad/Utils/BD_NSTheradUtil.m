//
//  BD_NSTheradUtil.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/2/8.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_NSTheradUtil.h"

@interface BD_NSTheradUtil()
@property (nonatomic, strong) NSThread *thread1;

@property (nonatomic, strong) NSTimer *threadTimer;

@end


@implementation BD_NSTheradUtil


-(void)StartTheThread{
    __weak __typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            strongSelf.thread1 = [NSThread currentThread];
            [strongSelf.thread1 setName:@"Thread1"];
            strongSelf.threadTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:strongSelf selector:@selector(timerAction) userInfo:nil repeats:YES];
            NSRunLoop *runloop = [NSRunLoop currentRunLoop];
            [runloop addTimer:strongSelf.threadTimer forMode:NSDefaultRunLoopMode];
            [runloop run];
        }
    });
}


-(void)timerAction{
    
    
}
- (void)cancelTimer{
    
    if (self.threadTimer && self.thread1) {
        
        [self performSelector:@selector(cancel) onThread:self.thread1 withObject:nil waitUntilDone:YES];
        
    }
    
}


- (void)cancel{
    
    if (self.threadTimer) {
        
        [self.threadTimer invalidate];
        self.threadTimer = nil;
        [self.thread1 cancel];
    }

}

//退出当前线程
-(void)exitCurrentTherad{
    
    if(self.thread1.isCancelled){//线程取消只是一个标记，真正完成退出必须调用exit方法
        [NSThread exit];
    }
}
@end
