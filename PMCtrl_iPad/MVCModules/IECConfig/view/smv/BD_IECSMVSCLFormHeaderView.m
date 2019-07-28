//
//  BD_IECSMVSCLFormHeaderView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/8.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_IECSMVSCLFormHeaderView.h"

@implementation BD_IECSMVSCLFormHeaderView

-(instancetype)initWithTitls:(NSArray *)titleArr viewWidth:(CGFloat)viewWidth{
    if (self = [super init]) {
        _headerTitles = titleArr;
        _viewWidth = viewWidth;
        self.backgroundColor = FormBgColor;
        [self createViews];
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    
}

-(NSArray *)headerTitles{
    if (!_headerTitles) {
        _headerTitles  = [[NSArray alloc]init];
    }
    return _headerTitles;
}
-(void)createViews{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
   
    CGFloat leading = 10;
    CGFloat width = (_viewWidth-60-leading*(_headerTitles.count-1))/_headerTitles.count;
    CGFloat height = 30;
    CGFloat y = 10;
    for (NSInteger i = 0; i<_headerTitles.count; i++) {
        UILabel *label = [[UILabel alloc]init];
       
        label.textColor = White;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = _headerTitles[i];
        if (i == 0) {
            label.frame = CGRectMake(50, y, width, height);
        } else {
            label.frame = CGRectMake(50+(i*(leading+width)), y, width, height);
        }
        [self addSubview:label];
//        if (i==0) { 
//            [label mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.width.mas_equalTo(label.mas_width);
//                make.height.mas_equalTo(30);
//                make.left.mas_equalTo(weakself.mas_left).offset(30);
//
//                make.centerY.mas_equalTo(weakself.centerY);
//            }];
//        } else {
//            [label mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.width.mas_equalTo(label.mas_width);
//                make.height.mas_equalTo(30);
//
//                make.left.mas_equalTo(weakself.mas_left).offset(10+i*(10+_viewWidth/_headerTitles.count));
//                make.centerY.mas_equalTo(weakself.centerY);
//            }];
//        }
        
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
