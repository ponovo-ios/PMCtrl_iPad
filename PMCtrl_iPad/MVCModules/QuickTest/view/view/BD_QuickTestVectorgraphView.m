//
//  BD_QuickTestVectorgraphView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/17.
//  Copyright © 2017年 ponovo. All rights reserved.
//




#import "BD_QuickTestVectorgraphView.h"
/**禁用，后来没有用到*/
@implementation BD_QuickTestVectorgraphView

-(void)setViewData:(BD_QuickTestVactorgraphModel *)viewData{
    _viewData = viewData;
}

#pragma  mark - 懒加载
-(NSMutableDictionary *)drawLineDic{
    if (!_drawLineDic) {
        _drawLineDic = [@{@"Ua":@(YES),
                         @"Ub":@(YES),
                         @"Uc":@(YES),
                         @"Uz":@(YES),
                         @"Ia":@(YES),
                         @"Ib":@(YES),
                         @"Ic":@(YES),
                         } mutableCopy];
                         
    }
    return _drawLineDic;
}
-(NSArray<NSString *> *)lineTitleArr{
    if (!_lineTitleArr) {
        _lineTitleArr = @[@"Ua",@"Ub",@"Uc",@"Uz",@"Ia",@"Ib",@"Ic"];
    }
    return _lineTitleArr;
}
- (void)drawRect:(CGRect)rect {
    
    
    //1.设置圆心
    CGPoint centerP = CGPointMake(self.width/2, self.height/2);
    //设置半径
    CGFloat radius = rect.size.height/2;
    
    //设置起始弧度
    CGFloat start = 0;
    //设置结束弧度
    CGFloat end = 2 * M_PI;
    
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:centerP radius:radius startAngle:start endAngle:end clockwise:YES];
    
    [[UIColor blackColor]set];
    //渲染
    [path fill];
    
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
    
    
   /*
    
#pragma mark - Va
    if (_viewData.voltageArr.count!=0) {
        if ([[self.drawLineDic objectForKey:@"Ua"]isEqual:@(YES)]) {
            
            NSDictionary * attrs = @{
                                     NSForegroundColorAttributeName:[UIColor yellowColor],
                                     NSFontAttributeName:[UIFont systemFontOfSize:15.0]
                                     };
            
            CGFloat VaAmplitude = [_viewData.voltageArr[0].Amplitude floatValue];
            CGFloat VaPhase = [_viewData.voltageArr[0].Phase floatValue]/180 *-M_PI;
            CGFloat VaRadius = VaAmplitude/MAX_V_Amplitude*radius;
            
            UIBezierPath * VaPath = [UIBezierPath bezierPathWithArcCenter:centerP radius:VaRadius startAngle:start endAngle:VaPhase clockwise:YES];
            //连接终点和圆心
            UIBezierPath *pathVa = [UIBezierPath bezierPath];
            [pathVa moveToPoint:VaPath.currentPoint];
            [pathVa addLineToPoint:centerP];
            
            [[UIColor yellowColor] set];
            [pathVa stroke];
            
            //绘制文字
            NSString * strVa = self.lineTitleArr[0];
            UIBezierPath * VaP = [UIBezierPath bezierPathWithArcCenter:centerP radius:(VaRadius+13) startAngle:start endAngle:VaPhase clockwise:YES];
            
            [strVa drawInRect:CGRectMake(VaP.currentPoint.x-10, VaP.currentPoint.y-10, 30, 20) withAttributes:attrs];
        }
        
        
#pragma mark - Vb
        if ([[self.drawLineDic objectForKey:@"Ub"]isEqual:@(YES)]) {
            NSDictionary * attrsVb = @{
                                       NSForegroundColorAttributeName:[UIColor greenColor],
                                       NSFontAttributeName:[UIFont systemFontOfSize:15.0]
                                       };
            CGFloat VbAmplitude = [_viewData.voltageArr[1].Amplitude floatValue];
            CGFloat VbPhase = [_viewData.voltageArr[1].Phase floatValue]/180 *-M_PI;
            CGFloat VbRadius = VbAmplitude/MAX_V_Amplitude*radius;
            
            UIBezierPath * VbPath = [UIBezierPath bezierPathWithArcCenter:centerP radius:VbRadius startAngle:start endAngle:VbPhase clockwise:YES];
            //连接终点和圆心
            UIBezierPath *pathVb = [UIBezierPath bezierPath];
            [pathVb moveToPoint:VbPath.currentPoint];
            [pathVb addLineToPoint:centerP];
            
            [[UIColor greenColor] set];
            [pathVb stroke];
            
            
            //绘制文字
            NSString * strVb = self.lineTitleArr[1];
            UIBezierPath * VbP = [UIBezierPath bezierPathWithArcCenter:centerP radius:VbRadius+13 startAngle:start endAngle:VbPhase clockwise:YES];
            [strVb drawInRect:CGRectMake(VbP.currentPoint.x-10, VbP.currentPoint.y-10, 30, 20) withAttributes:attrsVb];
        }
        
#pragma mark - Vc
        
        if ([[self.drawLineDic objectForKey:@"Uc"]isEqual:@(YES)]) {
            NSDictionary * attrsVc = @{
                                       NSForegroundColorAttributeName:[UIColor redColor],
                                       NSFontAttributeName:[UIFont systemFontOfSize:15.0]
                                       };
            
            CGFloat VcPhase = [_viewData.voltageArr[2].Phase floatValue]/180 *-M_PI;
            CGFloat VcAmplitude = [_viewData.voltageArr[2].Amplitude floatValue];
            CGFloat VcRadius = VcAmplitude/MAX_V_Amplitude*radius;
            UIBezierPath * VcPath = [UIBezierPath bezierPathWithArcCenter:centerP radius:VcRadius startAngle:start endAngle:VcPhase clockwise:YES];
            //连接终点和圆心
            UIBezierPath *pathVc = [UIBezierPath bezierPath];
            [pathVc moveToPoint:VcPath.currentPoint];
            [pathVc addLineToPoint:centerP];
            
            [[UIColor redColor] set];
            [pathVc stroke];
            
            //绘制文字
            NSString * strVc = self.lineTitleArr[2];
            UIBezierPath * VcP = [UIBezierPath bezierPathWithArcCenter:centerP radius:VcRadius+13 startAngle:start endAngle:VcPhase clockwise:YES];
            [strVc drawInRect:CGRectMake(VcP.currentPoint.x-10, VcP.currentPoint.y-10, 30, 20)  withAttributes:attrsVc];
        }
        
        //#pragma mark - Vz
        if (_viewData.voltageArr.count>3) {
            if ([[self.drawLineDic objectForKey:@"Uz"]isEqual:@(YES)]) {
                NSDictionary * attrsVz = @{
                                           NSForegroundColorAttributeName:[UIColor blueColor],
                                           NSFontAttributeName:[UIFont systemFontOfSize:15.0]
                                           };
                CGFloat VzPhase = [_viewData.voltageArr[3].Phase floatValue]/180 *-M_PI;
                CGFloat VzAmplitude = [_viewData.voltageArr[3].Amplitude floatValue];
                CGFloat VzRadius = VzAmplitude/MAX_V_Amplitude*radius;
                UIBezierPath * VzPath = [UIBezierPath bezierPathWithArcCenter:centerP radius:VzRadius startAngle:start endAngle:VzPhase clockwise:NO];
                //连接终点和圆心
                UIBezierPath *pathVz = [UIBezierPath bezierPath];
                [pathVz moveToPoint:VzPath.currentPoint];
                [pathVz addLineToPoint:centerP];
                
                [[UIColor blueColor] set];
                [pathVz stroke];
                
                //绘制文字
                
                NSString * strVz = self.lineTitleArr[3];
                UIBezierPath * VzP = [UIBezierPath bezierPathWithArcCenter:centerP radius:VzRadius+13 startAngle:start endAngle:VzPhase clockwise:NO];
                [strVz drawInRect:CGRectMake(VzP.currentPoint.x-10, VzP.currentPoint.y-10, 20, 20) withAttributes:attrsVz];
                
            }
        }
    }
    
    if (_viewData.currentArr.count!=0) {
#pragma mark - Ia
        if ([[self.drawLineDic objectForKey:@"Ia"]isEqual:@(YES)]) {
            NSDictionary * attrsIa = @{
                                       NSForegroundColorAttributeName:[UIColor yellowColor],
                                       NSFontAttributeName:[UIFont systemFontOfSize:15.0]
                                       };
            
            CGFloat IaAmplitude = [_viewData.currentArr[0].Amplitude floatValue];
            CGFloat IaPhase = [_viewData.currentArr[0].Phase floatValue]/180 *-M_PI;
            CGFloat IaRadius = IaAmplitude/MAX_I_Amplitude*radius;
            
            UIBezierPath * IaPath = [UIBezierPath bezierPathWithArcCenter:centerP radius:IaRadius startAngle:start endAngle:IaPhase clockwise:YES];
            //连接终点和圆心
            UIBezierPath *pathIa = [UIBezierPath bezierPath];
            [pathIa moveToPoint:IaPath.currentPoint];
            [pathIa addLineToPoint:centerP];
            
            [[UIColor yellowColor] set];
            [pathIa stroke];
            
            //绘制文字
            NSString * strIa = self.lineTitleArr[self.lineTitleArr.count-3];
            
            UIBezierPath * IaP = [UIBezierPath bezierPathWithArcCenter:centerP radius:(IaRadius+13) startAngle:start endAngle:IaPhase clockwise:YES];
            
            [strIa drawInRect:CGRectMake(IaP.currentPoint.x-10, IaP.currentPoint.y-10, 20, 20) withAttributes:attrsIa];
        }
#pragma mark - Ib
        if ([[self.drawLineDic objectForKey:@"Ib"]isEqual:@(YES)]) {
            NSDictionary * attrsIb = @{
                                       NSForegroundColorAttributeName:[UIColor greenColor],
                                       NSFontAttributeName:[UIFont systemFontOfSize:15.0]
                                       };
            
            CGFloat IbAmplitude = [_viewData.currentArr[1].Amplitude floatValue];
            CGFloat IbPhase = [_viewData.currentArr[1].Phase floatValue]/180 *-M_PI;
            CGFloat IbRadius = IbAmplitude/MAX_I_Amplitude*radius;
            
            UIBezierPath * IbPath = [UIBezierPath bezierPathWithArcCenter:centerP radius:IbRadius startAngle:start endAngle:IbPhase clockwise:YES];
            //连接终点和圆心
            UIBezierPath *pathIb = [UIBezierPath bezierPath];
            [pathIb moveToPoint:IbPath.currentPoint];
            [pathIb addLineToPoint:centerP];
            
            [[UIColor greenColor] set];
            [pathIb stroke];
            
            //绘制文字
            NSString * strIb = self.lineTitleArr[self.lineTitleArr.count-2];
            UIBezierPath * IbP = [UIBezierPath bezierPathWithArcCenter:centerP radius:(IbRadius+13) startAngle:start endAngle:IbPhase clockwise:YES];
            
            [strIb drawInRect:CGRectMake(IbP.currentPoint.x-10, IbP.currentPoint.y-10, 20, 20) withAttributes:attrsIb];
        }
#pragma mark - Ic
        if ([[self.drawLineDic objectForKey:@"Ic"]isEqual:@(YES)]) {
            NSDictionary * attrsIc = @{
                                       NSForegroundColorAttributeName:[UIColor redColor],
                                       NSFontAttributeName:[UIFont systemFontOfSize:15.0]
                                       };
            
            CGFloat IcAmplitude = [_viewData.currentArr[2].Amplitude floatValue];
            CGFloat IcPhase = [_viewData.currentArr[2].Phase floatValue]/180 *-M_PI;
            CGFloat IcRadius = IcAmplitude/MAX_I_Amplitude*radius;
            
            UIBezierPath * IcPath = [UIBezierPath bezierPathWithArcCenter:centerP radius:IcRadius startAngle:start endAngle:IcPhase clockwise:YES];
            //连接终点和圆心
            UIBezierPath *pathIc = [UIBezierPath bezierPath];
            [pathIc moveToPoint:IcPath.currentPoint];
            [pathIc addLineToPoint:centerP];
            
            [[UIColor redColor] set];
            [pathIc stroke];
            
            //绘制文字
            NSString * strIc = self.lineTitleArr[self.lineTitleArr.count-1];
            UIBezierPath * IcP = [UIBezierPath bezierPathWithArcCenter:centerP radius:(IcRadius+13) startAngle:start endAngle:IcPhase clockwise:YES];
            
            [strIc drawInRect:CGRectMake(IcP.currentPoint.x-10, IcP.currentPoint.y-10, 20, 20) withAttributes:attrsIc];
            
        }
    }
*/
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
