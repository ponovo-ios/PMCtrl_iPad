//
//  BD_BinaryStateLineView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/24.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_BinaryStateLineView.h"
#import "BD_BinaryLineBaseView.h"
#define Margin_X 60
#define Margin_Y 20
@interface BD_BinaryStateLineView()
@property(nonatomic,strong)NSMutableArray<BD_BinaryLineBaseView *> *stateLineViews;
@property(nonatomic,strong)NSMutableArray<CATextLayer *> *textLayers;

@end
static CGFloat const x_scaleHeight=5;

@implementation BD_BinaryStateLineView

-(void)drawRect:(CGRect)rect{
    
    
    //x轴
    UIBezierPath *xLinePath = [UIBezierPath bezierPath];
    
    [xLinePath moveToPoint:CGPointMake(Margin_X, self.height-2*Margin_Y)];
    [xLinePath addLineToPoint:CGPointMake(self.width-Margin_X, self.height-2*Margin_Y)];
    
    xLinePath.lineWidth = 1;
    [_coordinateColor set];
    [xLinePath stroke];
    //y轴
    UIBezierPath *yLinePath = [UIBezierPath bezierPath];
    
    [yLinePath moveToPoint:CGPointMake(Margin_X,Margin_Y)];
    [yLinePath addLineToPoint:CGPointMake(Margin_X, self.height-2*Margin_Y)];
    yLinePath.lineWidth = 1;
    [_coordinateColor set];
    [yLinePath stroke];
    
    //状态图
    if (!self.stateLineViews || self.stateLineViews.count == 0) {
        [self addBinaryView:self.binaryStateDataSource];
    } else {
        for (int i = 0;i<self.stateLineViews.count;i++) {
            self.stateLineViews[i].lineDataArr = [self.binaryStateDataSource[i].lineData copy];
            [self.stateLineViews[i] setNeedsDisplay];
        }
    }
    
    if (!self.textLayers || self.textLayers.count == 0) {
        //x轴下方的刻度线
        [self createX_downLine:self.xValues];
    } else {
        for (int n = 0; n<self.textLayers.count; n++) {
            self.textLayers[n].string = [NSString stringWithFormat:@"%d",[self.xValues[n] intValue]];
        }
    }
    
    
}
//禁用
//-(void)drawBinaryStartLine:(NSArray<BD_BinaryStateModel *> *)binaryState{
//
//
//    CGFloat lineToLineDis = (self.height-2*Margin_Y)*0.8/binaryState.count;
//    CGFloat bottomLineY = self.height-2*Margin_Y - lineToLineDis;
//
//    for (int i = 0; i<binaryState.count; i++) {
//        CAShapeLayer *stateLayer = [CAShapeLayer layer];
//        stateLayer.strokeColor = [UIColor redColor].CGColor;
//        UIBezierPath *statePath = [UIBezierPath bezierPath];
//        [statePath moveToPoint:CGPointMake(Margin_X, bottomLineY-i*lineToLineDis)];
//
//        [statePath addLineToPoint:CGPointMake(self.width-2*Margin_X, bottomLineY-i*lineToLineDis)];
//        CATextLayer *textlayer = [CATextLayer layer];
//        textlayer.frame = CGRectMake(Margin_X-25,bottomLineY-i*lineToLineDis-10, 35,25);
//        textlayer.string = binaryState[i].binaryName;
//        textlayer.foregroundColor = [UIColor blackColor].CGColor;
//        textlayer.alignmentMode = kCAAlignmentCenter;
//        textlayer.wrapped = YES;
//
//        UIFont *font = [UIFont systemFontOfSize:15];
//
//        CFStringRef fontName = (__bridge CFStringRef)font.fontName;
//        CGFontRef fontRef = CGFontCreateWithFontName(fontName);
//        textlayer.font = fontRef;
//        textlayer.fontSize = font.pointSize;
//        CGFontRelease(fontRef);
//        [stateLayer addSublayer:textlayer];
//        if (binaryState[i].binaryState == YES) {
//            stateLayer.lineWidth = 5;
//        } else {
//            stateLayer.lineWidth = 1;
//        }
//        stateLayer.path = statePath.CGPath;
//
//        [self.layer addSublayer:stateLayer];
//        [_stateLayerArr addObject:stateLayer];
//    }
//
//
//}

-(void)addBinaryView:(NSArray<BD_BinaryStateViewModel*> *)binaryState{
    CGFloat lineToLineDis = (self.height-2*Margin_Y)*0.8/binaryState.count;
    CGFloat bottomLineY = self.height-2*Margin_Y - lineToLineDis;
    
    for (int i = 0; i<binaryState.count; i++) {
        BD_BinaryLineBaseView *baseView = [BD_BinaryLineBaseView new];
        baseView.backgroundColor = ClearColor;
        baseView.lineColor = _statelineColor;
        baseView.xmaxValue = [self bubbleSortToMax:[_xValues mutableCopy]]-[self bubbleSortToMin:[_xValues mutableCopy]];
        [baseView setFrame:CGRectMake(Margin_X+1, bottomLineY-i*lineToLineDis,self.width-2*Margin_X,10)];
        baseView.lineDataArr = [binaryState[i].lineData copy];
        [baseView setNeedsDisplay];
        [self.stateLineViews addObject:baseView];
        [self addSubview:baseView];
        
        CATextLayer *textlayer = [CATextLayer layer];
        textlayer.frame = CGRectMake(Margin_X-25,bottomLineY-i*lineToLineDis, 35,25);
        textlayer.string = binaryState[i].binaryName;
        textlayer.foregroundColor = _xValuesColor.CGColor;
        textlayer.alignmentMode = kCAAlignmentCenter;
        textlayer.wrapped = YES;
        
        UIFont *font = [UIFont systemFontOfSize:15];
        
        CFStringRef fontName = (__bridge CFStringRef)font.fontName;
        CGFontRef fontRef = CGFontCreateWithFontName(fontName);
        textlayer.font = fontRef;
        textlayer.fontSize = font.pointSize;
        CGFontRelease(fontRef);
        [self.layer addSublayer:textlayer];
    }
}

-(void)createX_downLine:(NSArray<NSNumber *> *)xTitleArray{
    //x轴下方竖线
    CAShapeLayer *lineLayer= [CAShapeLayer layer];
    lineLayer.fillColor = [UIColor clearColor].CGColor;
    lineLayer.lineWidth = 1.0f;
    lineLayer.strokeColor = _coordinateColor.CGColor;
    CGFloat X = 0;
    CGFloat Y = self.height-2*Margin_Y;
    UIBezierPath *line1Path = [UIBezierPath bezierPath];
    
    for (int i = 0; i < xTitleArray.count*2; i++) {
       
        CATextLayer *textlayer = [CATextLayer layer];
       
        textlayer.string = [NSString stringWithFormat:@"%d",[xTitleArray[i/2] intValue]];
        textlayer.foregroundColor = _xValuesColor.CGColor;
        textlayer.alignmentMode = kCAAlignmentCenter;
        textlayer.wrapped = YES;
        
        UIFont *font = [UIFont systemFontOfSize:15];
        
        CFStringRef fontName = (__bridge CFStringRef)font.fontName;
        CGFontRef fontRef = CGFontCreateWithFontName(fontName);
        textlayer.font = fontRef;
        textlayer.fontSize = font.pointSize;
        CGFontRelease(fontRef);
        
        if (i%2 == 0) {
            [line1Path moveToPoint:CGPointMake(X + Margin_X + (self.width - Margin_X * 2) / (xTitleArray.count - 1)/2 * i,Y)];
            [line1Path addLineToPoint:CGPointMake(X + Margin_X + (self.width - Margin_X * 2) / (xTitleArray.count - 1)/2 * i,Y+x_scaleHeight*2)];
            textlayer.frame = CGRectMake(X + Margin_X + (self.width - Margin_X * 2) / (xTitleArray.count - 1)/2 * i-18,Y+5, 35,25);
            [self.textLayers addObject:textlayer];
            [self.layer addSublayer:textlayer];
        } else if (i !=xTitleArray.count*2-1 ) {
            [line1Path moveToPoint:CGPointMake(X + Margin_X + (self.width - Margin_X * 2) / (xTitleArray.count - 1)/2 * i,Y)];
            [line1Path addLineToPoint:CGPointMake(X + Margin_X + (self.width - Margin_X * 2) / (xTitleArray.count - 1)/2 * i,Y+x_scaleHeight)];
        }
        
    }
    lineLayer.path = line1Path.CGPath;
    
    [self.layer addSublayer:lineLayer];
    
}

//获取x轴中最大的值  从小到大
-(int)bubbleSortToMax:(NSMutableArray *)unorderedArr{
//    //选择
//    
//    for (int  i =0; i<unorderedArr.count-1; i++) {
//        
//        for (int j = i+1; j<unorderedArr.count; j++) {
//            
//            if ([unorderedArr[i] intValue]>[unorderedArr[j] intValue]) {
//                
//                //交换
//                
//                [unorderedArr exchangeObjectAtIndex:i withObjectAtIndex:j];
//                
//            }
//            
//        }
//        
//    }
//    
//    NSLog(@"%@",unorderedArr);
    return [unorderedArr[unorderedArr.count-1] intValue];
}

//获取x轴中最小的值 从小到大排序
-(int)bubbleSortToMin:(NSMutableArray *)unorderedArr{
        //选择
    
//        for (int  i =0; i<unorderedArr.count-1; i++) {
//    
//            for (int j = i+1; j<unorderedArr.count; j++) {
//    
//                if ([unorderedArr[i] intValue]>[unorderedArr[j] intValue]) {
//    
//                    //交换
//    
//                    [unorderedArr exchangeObjectAtIndex:i withObjectAtIndex:j];
//    
//                }
//    
//            }
//    
//        }
//    
//        NSLog(@"%@",unorderedArr);
    return [unorderedArr[0] intValue];
}


#pragma mark - 懒加载
-(NSArray *)xValues{
    if (!_xValues) {
        _xValues = @[@(0),@(10),@(20),@(30),@(40),@(50),@(60),@(70),@(80),@(90)];
    }
    return _xValues;
}

-(NSArray<BD_BinaryStateViewModel *> *)binaryStateDataSource{
    if (!_binaryStateDataSource) {
        _binaryStateDataSource = [[NSArray alloc]init];
    }
    return _binaryStateDataSource;
}
-(UIColor *)statelineColor{
    if (!_statelineColor) {
        _statelineColor = Black;
    }
    return _statelineColor;
}
-(UIColor *)coordinateColor{
    if (!_coordinateColor) {
        _coordinateColor = Black;
    }
    return _coordinateColor;
}
-(UIColor *)xValuesColor{
    if (_xValuesColor) {
        _xValuesColor = Black;
    }
    return _xValuesColor;
}
-(NSMutableArray<BD_BinaryLineBaseView *>*)stateLineViews{
    if (!_stateLineViews) {
        _stateLineViews = [[NSMutableArray alloc]init];
    }
    return _stateLineViews;
}
-(NSMutableArray<CATextLayer *>*)textLayers{
    if (!_textLayers) {
        _textLayers = [[NSMutableArray alloc]init];
    }
    return _textLayers;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
