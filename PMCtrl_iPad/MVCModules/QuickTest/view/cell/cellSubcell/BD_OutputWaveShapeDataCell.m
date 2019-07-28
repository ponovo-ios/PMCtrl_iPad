//
//  BD_OuptupWaveShapeDataCell.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/28.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_OutputWaveShapeDataCell.h"

@implementation BD_OutputWaveShapeDataCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_selectedBtn setImage:[UIImage imageNamed:@"select_gray"] forState:UIControlStateNormal];
    [_selectedBtn setImage:[UIImage imageNamed:@"select_blue"] forState:UIControlStateSelected];
    [_selectedBtn setSelected:YES];
    self.backgroundColor = ClearColor;
    self.contentView.backgroundColor = ClearColor;
    self.amplitudeValue.adjustsFontSizeToFitWidth = YES;
    self.phaseValue.adjustsFontSizeToFitWidth = YES;
    self.lineMarkColorView.backgroundColor = ClearColor;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)selectedBtnClick:(id)sender {
    [_selectedBtn setSelected:!_selectedBtn.selected];
    self.selectedBlock(_selectedBtn.selected, _cellIndex);
}

-(void)addLayerToMarkViewWithColor:(UIColor *)color title:(NSString *)title{
    //波形图标签，为了显示虚线
    [_lineMarkColorView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.tag ==1111) {
            [obj removeFromSuperview];
        }
    }];
    UIView *layerView = [[UIView alloc]init];
    [layerView setFrame:_lineMarkColorView.bounds];
    layerView.tag =1111;
    CAShapeLayer *layer2 = [CAShapeLayer new];
    layer2.lineWidth = _lineMarkColorView.height;
    layer2.strokeColor = color.CGColor;
    layer2.fillColor = color.CGColor;
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(0,_lineMarkColorView.height/2)];
    [path2 addLineToPoint:CGPointMake(_lineMarkColorView.width, _lineMarkColorView.height/2)];
    layer2.path = [path2 CGPath];
    
    if ([title hasPrefix:@"I"]) {
        [layer2 setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:2],[NSNumber numberWithInt:2], nil]];
    }
    [layerView.layer addSublayer:layer2];
    
    [_lineMarkColorView addSubview:layerView];
}
@end
