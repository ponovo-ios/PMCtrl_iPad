//
//  BD_FingerWaveView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/16.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_FingerWaveView.h"


@interface BD_FingerWaveView () <CAAnimationDelegate>
{
    CGSize waveSize;
    NSTimeInterval duration;
}
@end
@implementation BD_FingerWaveView
- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        waveSize = CGSizeMake(150, 150);
        duration = 0.5;
    }
    return self;
}
+ (instancetype)showInView:(UIView *)view center:(CGPoint)center {
    BD_FingerWaveView *waveView = [BD_FingerWaveView new];
    [waveView setframeWithCenter:center];
    [view addSubview:waveView];
    return waveView;
}
- (void)didMoveToSuperview{
    CAShapeLayer *waveLayer = [CAShapeLayer new];
    waveLayer.backgroundColor = [UIColor clearColor].CGColor;
    waveLayer.opacity = 0.6;
    waveLayer.fillColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:waveLayer];
    
    [self startAnimationInLayer:waveLayer];
}
- (void)startAnimationInLayer:(CALayer *)layer{
    UIBezierPath *beginPath = [UIBezierPath bezierPathWithArcCenter:[self pathCenter] radius:[self animationBeginRadius] startAngle:0 endAngle:M_PI*2 clockwise:YES];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithArcCenter:[self pathCenter] radius:[self animationEndRadius] startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    CABasicAnimation *rippleAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    rippleAnimation.delegate = self;
    rippleAnimation.fromValue = (__bridge id _Nullable)(beginPath.CGPath);
    rippleAnimation.toValue = (__bridge id _Nullable)(endPath.CGPath);
    rippleAnimation.duration = duration;
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.delegate = self;
    opacityAnimation.fromValue = [NSNumber numberWithFloat:0.6];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.0];
    opacityAnimation.duration = duration;
    
    [layer addAnimation:rippleAnimation forKey:@"rippleAnimation"];
    [layer addAnimation:opacityAnimation forKey:@"opacityAnimation"];
}
- (void)setframeWithCenter:(CGPoint)center{
    CGRect frame = CGRectMake(center.x-waveSize.width*0.5, center.y-waveSize.height*0.5, waveSize.width, waveSize.height);
    self.frame = frame;;
}
- (CGFloat)animationBeginRadius{
    return waveSize.width*0.5*0.2;
}
- (CGFloat)animationEndRadius{
    return waveSize.width*0.5;
}
- (CGPoint)pathCenter{
    return CGPointMake(waveSize.width*0.5, waveSize.height*0.5);
}
#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag) {
        [self removeFromSuperview];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
