//
//  BD_HarmWaveformSelView.m
//  PMCtrl_iPad
//
//  Created by wanggx on 2018/1/25.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_HarmWaveformSelView.h"

@implementation BD_HarmWaveformSelView

-(instancetype)initWithFrame:(CGRect)frame type:(WaveformLeftType)type
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI:type];
    }
    return self;
}

-(void)setupUI:(WaveformLeftType)type
{
    NSInteger n = 0;
    NSArray *titleArray;
    
    switch (type) {
        case LIFT_S_V:
            n = 4;
            titleArray = @[@"Ua", @"Ub", @"Uc", @"Uz"];
            break;
        case LIFT_S_C:
            n = 3;
            titleArray = @[@"Ia", @"Ib", @"Ic"];
            break;
        case LIFT_N_V:
            n = 4;
            titleArray = @[@"Ua`", @"Ub`", @"Uc`", @"Uz`"];
            break;
        case LIFT_N_C:
            n = 3;
            titleArray = @[@"Ia`", @"Ib`", @"Ic`"];
            break;
        case LIFT_S_V1:
            n = 3;
            titleArray = @[@"Ua", @"Ub", @"Uc"];
            break;
        case LIFT_S_V2:
            n = 3;
            titleArray = @[@"Ua2", @"Ub2", @"Uc2"];
            break;
        case LIFT_S_C1:
            n = 3;
            titleArray = @[@"Ia", @"Ib", @"Ic"];
            break;
        case LIFT_S_C2:
            n = 3;
            titleArray = @[@"Ia2", @"Ib2", @"Ic2"];
            break;
        case LIFT_N_V1:
            n = 3;
            titleArray = @[@"Ua`", @"Ub`", @"Uc`"];
            break;
        case LIFT_N_V2:
            n = 3;
            titleArray = @[@"Ua2`", @"Ub2`", @"Uc2`"];
            break;
        case LIFT_N_C1:
            n = 3;
            titleArray = @[@"Ia`", @"Ib`", @"Ic`"];
            break;
        case LIFT_N_C2:
            titleArray = @[@"Ia2`", @"Ib2`", @"Ic2`"];
            n = 3;
            break;
            
        default:
            break;
    }
    
    NSArray *colorArray = @[[UIColor yellowColor], [UIColor greenColor], [UIColor redColor], [UIColor blueColor]];
    
    CGFloat x = 0;
    CGFloat w = self.width - 40;
    CGFloat h = self.height / n;
    
    for (NSInteger i = 0; i < n; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"waveformBtn"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"waveformBtn_sel"] forState:UIControlStateSelected];
        btn.tag = i;
        btn.frame = CGRectMake(x, i * h, w, h);
//        btn.backgroundColor = RandomColor;
        
//        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        
        [self addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.selected = YES;
        
        UIView *v = [[UIView alloc] init];
        v.centerY = btn.centerY - Marge;
        v.x = w;
        v.width = 40;
        v.height = 20;
        v.backgroundColor = colorArray[i];
        [self addSubview:v];
    }
    
    
}


-(void)btnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    //按钮点击
    [self.delegate waveformDidChangeWith:sender];
}


@end
