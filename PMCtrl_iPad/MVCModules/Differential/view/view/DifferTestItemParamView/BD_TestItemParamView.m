//
//  BD_TestItemParamView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/11.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_TestItemParamView.h"
#import "BD_DifferQDCurrentParamView.h"
#import "BD_DifferHarmParamView.h"
#import "BD_DifferActionTimeParamView.h"
#import "BD_DifferentialTestItemModel.h"
#import "BD_DifferSetDataModel.h"
@interface BD_TestItemParamView()<UIScrollViewDelegate>

@property(nonatomic,strong)BD_DifferQDCurrentParamView *qdCurrentView;
@property(nonatomic,strong)BD_DifferHarmParamView *harmView;
@property(nonatomic,strong)BD_DifferActionTimeParamView *actionTimeView;

@end

@implementation BD_TestItemParamView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self confitTestItemParam];
    }
    return self;
}
-(void)layoutSubviews{
    _itemParamSCview.frame = self.bounds;
    _qdCurrentView.frame = CGRectMake(0, 0, self.itemParamSCview.width, self.itemParamSCview.height);
    
    _harmView.frame = CGRectMake( self.itemParamSCview.width,0, self.itemParamSCview.width, self.itemParamSCview.height);
    
    _actionTimeView.frame = CGRectMake(self.itemParamSCview.width*2,0, self.itemParamSCview.width, self.itemParamSCview.height);
    
    _itemParamSCview.contentSize = CGSizeMake(3*self.itemParamSCview.width, self.itemParamSCview.height);
}
-(void)confitTestItemParam{
    _itemParamSCview = [[UIScrollView alloc]init];
    _itemParamSCview.scrollEnabled = NO;
    _itemParamSCview.showsHorizontalScrollIndicator = NO;
    _itemParamSCview.delegate = self;
    [self addSubview:_itemParamSCview];
    
    _qdCurrentView = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([BD_DifferQDCurrentParamView class]) owner:nil options:nil].lastObject;
    _qdCurrentView.backgroundColor = ClearColor;
    [self.itemParamSCview addSubview:_qdCurrentView];
    
    _harmView = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([BD_DifferHarmParamView class]) owner:nil options:nil].lastObject;
    _harmView.backgroundColor = ClearColor;
    WeakSelf;
    _harmView.changeHarmNumBlock = ^{
        weakself.changeHarmNumBlock();
    };
    [self.itemParamSCview addSubview:_harmView];
    
    _actionTimeView = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([BD_DifferActionTimeParamView class]) owner:nil options:nil].lastObject;
    _actionTimeView.backgroundColor = ClearColor;
    [self.itemParamSCview addSubview:_actionTimeView];
    self.itemParamSCview.backgroundColor = ClearColor;
    
}


-(void)testItemParamViewWithIndex:(NSInteger)index{
    self.itemParamSCview.contentOffset = CGPointMake(self.itemParamSCview.frame.size.width*index, 0);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self endEditing:YES];
}

-(void)endEditing{
    [self endEditing:YES];
}


-(void)setDataToQDCurrentView:(BD_DifferentialTestItemParaModel *)data{
    self.qdCurrentView.viewData = data;
    [self.qdCurrentView setDataToQDCurrentView];
    
}
-(void)setDataToHarmView:(BD_DifferentialTestItemParaModel *)data{
    
    self.harmView.viewData = data;
    [self.harmView setDataToHarmView];
    
}
-(void)setDataToActionView:(BD_DifferentialTestItemParaModel *)data{
    self.actionTimeView.viewData = data;
    [self.actionTimeView setDataToActionView];
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
