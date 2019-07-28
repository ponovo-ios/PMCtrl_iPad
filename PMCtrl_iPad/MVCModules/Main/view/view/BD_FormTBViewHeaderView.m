//
//  BD_FormTBViewHeaderView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/21.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_FormTBViewHeaderView.h"
#import "UILabel+Extension.h"
@interface BD_FormTBViewHeaderView()
@property(nonatomic,strong)NSArray<UIView *> *lineViews;
@property(nonatomic,assign)UIView  *bottomLineview;
@end
@implementation BD_FormTBViewHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithNum:(int)num
{
    self = [super init];
    if (self) {
        [self loadSubViewsWithNum:num];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
 
    self.backgroundColor = ClearColor;
    // Initialization code
}

-(void)layoutSubviews{
    WeakSelf;
    CGFloat labelW = (self.width-self.formArr.count)/self.formArr.count;
    [_formArr enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.frame = CGRectMake(idx*labelW,0,labelW,weakself.height);
        if (idx != weakself.formArr.count-1) {
         weakself.lineViews[idx].frame = CGRectMake(obj.right,0,1,weakself.height);
        }
       
    }];
    
    _bottomLineview.frame= CGRectMake(0,self.height-1,self.width, 1);
}
-(void)loadSubViewsWithNum:(int)formNum{
    
    NSMutableArray *formLabels = [[NSMutableArray alloc]init];
    NSMutableArray *lineViews = [[NSMutableArray alloc]init];
    for (int i = 0; i<formNum; i++) {
        UILabel *lab = [UILabel labelWithText:@"" textColor:White fontSize:15 alignment:NSTextAlignmentCenter sizeToFit:YES];
        lab.backgroundColor = ClearColor;
        [self addSubview:lab];
        if (i!=formNum-1) {
            UIView *lineView = [[UIView alloc]init];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [self addSubview:lineView];
            [lineViews addObject:lineView];
        }
        [formLabels addObject:lab];
    }
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView];
    _bottomLineview = lineView;
    self.lineViews = [lineViews copy];
    self.formArr = [formLabels copy];
}

@end
