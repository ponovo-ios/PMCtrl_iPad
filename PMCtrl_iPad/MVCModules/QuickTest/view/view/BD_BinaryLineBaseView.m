//
//  BD_BinaryLineBaseView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/27.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_BinaryLineBaseView.h"

@implementation BD_BinaryLineBaseView

#pragma mark - 懒加载

-(NSArray<BD_BinaryStateModel*> *)lineDataArr{
    if (!_lineDataArr) {
        _lineDataArr = [[NSArray alloc]init];
    }
    return _lineDataArr;
}

-(UIColor *)lineColor{
    if (!_lineColor) {
        _lineColor = Black;
    }
    return _lineColor;
}

-(void)drawRect:(CGRect)rect{
    CGFloat line_Y = 5;
    UIBezierPath *mainPath = [UIBezierPath bezierPath];
    [mainPath moveToPoint:CGPointMake(0,line_Y)];
    [mainPath addLineToPoint:CGPointMake(0,line_Y)];
    CGPoint point = CGPointMake(0,line_Y);
    for (BD_BinaryStateModel *model in _lineDataArr) {
        
        UIBezierPath *linePath = [UIBezierPath bezierPath];
        if (model.binaryState) {
            linePath.lineWidth = 5;
        } else {
            linePath.lineWidth = 1;
        }
        [linePath moveToPoint:CGPointMake(mainPath.currentPoint.x+point.x,line_Y)];
        [linePath addLineToPoint:CGPointMake([self dataToscreenPixel:model.lengthData], line_Y)];
        point.x = linePath.currentPoint.x;
        [_lineColor set];
        [linePath stroke];
    }
    [_lineColor set];
    [mainPath stroke];
    
}

-(CGFloat)dataToscreenPixel:(CGFloat)data{
    return (self.width/_xmaxValue)*data;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
