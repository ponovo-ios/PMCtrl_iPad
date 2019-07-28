//
//  BD_RunLightAnimationManager.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/6/6.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_RunLightAnimationManager.h"
@interface BD_RunLightAnimationManager()
@property (nonatomic,strong) CADisplayLink *link;
@property (nonatomic,strong) CADisplayLink *changeSmallLink;

@end


@implementation BD_RunLightAnimationManager

-(instancetype)initWithView:(UIView *)view{
    if (self = [super init]) {
        _changeView = view;
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.changeSmallLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(changeSmallLinkTimeSelect)];
            [self.changeSmallLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        });
        
    }
    return self;
}

-(void)timeSelect{
    if (self.changeView) {
        self.changeView.backgroundColor = [UIColor greenColor];
        [self.link invalidate];
        self.link=nil;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.changeSmallLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(changeSmallLinkTimeSelect)];
            [self.changeSmallLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        });
        [self.changeView setNeedsDisplay];
    }

}

-(void)changeSmallLinkTimeSelect{
    if (self.changeView) {
        self.changeView.backgroundColor = [UIColor whiteColor];
        [self.changeSmallLink invalidate];
        self.changeSmallLink=nil;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(timeSelect)];
            [self.link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        });
    
        [self.changeView setNeedsDisplay];
    }
    
    
}
-(void)stopflashView{
        [self.changeSmallLink invalidate];
        [self.link invalidate];
        self.link=nil;
        self.changeSmallLink=nil;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.changeView.backgroundColor = [UIColor whiteColor];
        self.changeView = nil;
    });
}
@end
