//
//  BD_VectorgraphDrawView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/17.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_VectorgraphDrawView.h"
#import "BD_TestDataParamModel.h"
@interface BD_VectorgraphDrawView()

@end
@implementation BD_VectorgraphDrawView

#pragma mark - 懒加载
-(NSArray *)viewDatas{
    if (!_viewDatas) {
        _viewDatas = [[NSArray alloc]init];
    }
    return _viewDatas;
}
-(NSArray *)viewSelectedArr{
    if (!_viewSelectedArr) {
        _viewSelectedArr = @[@(YES),@(YES),@(YES),@(YES),@(YES),@(YES),@(YES),];
    }
    return _viewSelectedArr;
}
- (void)drawRect:(CGRect)rect {
    

    //1.设置圆心
    CGPoint centerP = CGPointMake(self.width/2, self.height/2);
    //设置半径
    CGFloat radius = (rect.size.height-25)/2;
    
    //设置起始弧度
    CGFloat start = 0;
    //设置结束弧度
    CGFloat end = 2 * M_PI;
    
    CAShapeLayer *layer = [CAShapeLayer new];
    layer.lineWidth = 1;
    //圆环的颜色
    layer.strokeColor = [UIColor whiteColor].CGColor;
    //背景填充色
    layer.fillColor = [UIColor clearColor].CGColor;
    //初始化一个路径
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:centerP radius:radius startAngle:start endAngle:end clockwise:YES];
    [[UIColor blackColor]set];
    [path fill];
    layer.path = [path CGPath];
    [self.layer addSublayer:layer];
                            
    
    CAShapeLayer *layer1 = [CAShapeLayer new];
    layer1.lineWidth = 1;
    //圆环的颜色
    layer1.strokeColor = [UIColor whiteColor].CGColor;
    //背景填充色
    layer1.fillColor = [UIColor clearColor].CGColor;   
    //初始化一个路径

    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:centerP radius:rect.size.height/8 startAngle:start endAngle:end clockwise:YES];
    layer1.path = [path1 CGPath];
    [layer1 setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:2],[NSNumber numberWithInt:2], nil]];
    [self.layer addSublayer:layer1];

    CAShapeLayer *layer2 = [CAShapeLayer new];
    layer2.lineWidth = 1;
    layer2.strokeColor = White.CGColor;
    layer2.fillColor = ClearColor.CGColor;
    UIBezierPath *path2 = [UIBezierPath bezierPathWithArcCenter:centerP radius:rect.size.height/4 startAngle:start endAngle:end clockwise:YES];
    layer2.path = [path2 CGPath];
    [layer2 setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:2],[NSNumber numberWithInt:2], nil]];
    [self.layer addSublayer:layer2];
    
    CAShapeLayer *layer3 = [CAShapeLayer new];
    layer3.lineWidth = 1;
    layer3.strokeColor = White.CGColor;
    layer3.fillColor = ClearColor.CGColor;
    UIBezierPath *path3 = [UIBezierPath bezierPathWithArcCenter:centerP radius:3*rect.size.height/8 startAngle:start endAngle:end clockwise:YES];
    layer3.path = [path3 CGPath];
    [layer3 setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:2],[NSNumber numberWithInt:2], nil]];
    [self.layer addSublayer:layer3];
    
    
    
    //2.坐标系
    UIBezierPath *pathLine = [UIBezierPath bezierPath];
    [pathLine moveToPoint:CGPointMake(self.width/2, self.height/2-radius)];
    [pathLine addLineToPoint:CGPointMake(self.width/2, self.height/2+radius)];
    [[UIColor whiteColor] set];
    [pathLine stroke];
    
    UIBezierPath *pathLine2 = [UIBezierPath bezierPath];
    [pathLine2 moveToPoint:CGPointMake(self.width/2-radius,self.height/2)];
    [pathLine2 addLineToPoint:CGPointMake(self.width/2+radius, self.height/2)];
    [[UIColor whiteColor] set];
    [pathLine2 stroke];
    
    WeakSelf;
    [_viewDatas enumerateObjectsUsingBlock:^(BD_TestDataParamModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.titleName rangeOfString:@"a"].location !=NSNotFound ||[obj.titleName rangeOfString:@"b"].location !=NSNotFound  || [obj.titleName rangeOfString:@"c"].location !=NSNotFound || [obj.titleName rangeOfString:@"z"].location !=NSNotFound){
            NSDictionary * attrs;
            
            CGFloat Amplitude = [obj.amplitude floatValue];
            
            CGFloat Phase = [obj.phase floatValue]/180 *-M_PI;
            CGFloat Radius;
            
            if ([obj.titleName hasPrefix:@"I"]) {
                Radius  = fabs(Amplitude)/_MAX_IAmplitude*radius;
                
            } else if ([obj.titleName hasPrefix:@"U"]) {
                Radius = fabs(Amplitude)/_MAX_UAmplitude*radius;
                
            } else {
                Radius = 0;
            }
            
            if ([weakself.viewSelectedArr[idx] boolValue]) {
                if (obj.amplitude.floatValue!=0) {
                    CGFloat arrowPhase = 0.000;
                    if ([obj.amplitude floatValue]<0) {
                        Phase = ([obj.phase floatValue]+180)/180 *-M_PI;
                        arrowPhase = [obj.phase floatValue]+180;
                    } else {
                         Phase = [obj.phase floatValue]/180 *-M_PI;
                        arrowPhase = [obj.phase floatValue];
                    }
                    UIBezierPath * Path = [UIBezierPath bezierPathWithArcCenter:centerP radius:Radius startAngle:start endAngle:Phase clockwise:YES];
                    //连接终点和圆心
                    UIBezierPath *pathVa = [UIBezierPath bezierPath];
                    [pathVa moveToPoint:Path.currentPoint];
                    [pathVa addLineToPoint:centerP];
                    
                   
                    [pathVa moveToPoint:[UIBezierPath bezierPathWithArcCenter:Path.currentPoint radius:10 startAngle:Phase endAngle:(arrowPhase-25+180)/180 *-M_PI clockwise:YES].currentPoint];
                    [pathVa addLineToPoint:Path.currentPoint];
                    
                    
                    [pathVa moveToPoint:[UIBezierPath bezierPathWithArcCenter:Path.currentPoint radius:10 startAngle:Phase endAngle:(arrowPhase+25-180)/180 *-M_PI clockwise:YES].currentPoint];
                    [pathVa addLineToPoint:Path.currentPoint];
                    
                    
                    if ([obj.titleName rangeOfString:@"a"].location != NSNotFound) {
                        attrs= @{
                                 NSForegroundColorAttributeName:Yellow,
                                 NSFontAttributeName:[UIFont systemFontOfSize:11.0]
                                 };
                        [Yellow set];
                    } else if ([obj.titleName rangeOfString:@"b"].location != NSNotFound) {
                        attrs= @{
                                 NSForegroundColorAttributeName:Green,
                                 NSFontAttributeName:[UIFont systemFontOfSize:11.0]
                                 };
                        [Green set];
                    } else if ([obj.titleName rangeOfString:@"c"].location != NSNotFound) {
                        attrs= @{
                                 NSForegroundColorAttributeName:Red,
                                 NSFontAttributeName:[UIFont systemFontOfSize:11.0]
                                 };
                        [Red set];
                    } else {
                        attrs= @{
                                 NSForegroundColorAttributeName:[UIColor blueColor],
                                 NSFontAttributeName:[UIFont systemFontOfSize:9.0]
                                 };
                        [[UIColor blueColor] set];
                    }
                    [pathVa stroke];
                    
                    //绘制文字
                    NSString * strVa = obj.titleName;
                    UIBezierPath * VaP;
                    if ([obj.phase floatValue]==-90) {
                        VaP = [UIBezierPath bezierPathWithArcCenter:centerP radius:(Radius+5) startAngle:start endAngle:Phase clockwise:YES];
                    } else {
                       VaP = [UIBezierPath bezierPathWithArcCenter:centerP radius:(Radius+10) startAngle:start endAngle:Phase clockwise:YES];
                    }
                    [strVa drawInRect:CGRectMake(VaP.currentPoint.x-10, VaP.currentPoint.y-5, 30, 20) withAttributes:attrs];
                    
                    
                }
            }
   
        }
        
    }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
