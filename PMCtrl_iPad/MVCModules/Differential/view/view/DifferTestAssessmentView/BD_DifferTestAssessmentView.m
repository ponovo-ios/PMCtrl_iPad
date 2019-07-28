//
//  BD_DifferTestAssessmentView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/11.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_DifferTestAssessmentView.h"
#import "BD_DifferQDCurrentAssessmentView.h"
#import "BD_DifferHarmAssessmentView.h"
#import "BD_DifferActionTimeAssessmentView.h"
#import "BD_DifferAssessmentModel.h"
@interface BD_DifferTestAssessmentView()
@property(nonatomic,strong)BD_DifferQDCurrentAssessmentView *qdCurrentAssView;
@property(nonatomic,strong)BD_DifferHarmAssessmentView *harmAssView;
@property(nonatomic,strong)BD_DifferActionTimeAssessmentView *actionTimeAssView;
@end

@implementation BD_DifferTestAssessmentView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self confitTestItemParam];
    }
    return self;
}
-(void)layoutSubviews{
    _itemParamSCview.frame = self.bounds;
    _qdCurrentAssView.frame = CGRectMake(0, 0, self.itemParamSCview.width, self.itemParamSCview.height);
    
    _harmAssView.frame = CGRectMake( self.itemParamSCview.width,0, self.itemParamSCview.width, self.itemParamSCview.height);
    
    _actionTimeAssView.frame = CGRectMake(self.itemParamSCview.width*2,0, self.itemParamSCview.width, self.itemParamSCview.height);
    
    _itemParamSCview.contentSize = CGSizeMake(3*self.itemParamSCview.width, self.itemParamSCview.height);
}
-(void)confitTestItemParam{
    WeakSelf;
    _itemParamSCview = [[UIScrollView alloc]init];
    _itemParamSCview.scrollEnabled = NO;
    _itemParamSCview.showsHorizontalScrollIndicator = NO;
    [self addSubview:_itemParamSCview];
    
    _qdCurrentAssView = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([BD_DifferQDCurrentAssessmentView class]) owner:nil options:nil].lastObject;
    _qdCurrentAssView.backgroundColor = ClearColor;
    _qdCurrentAssView.errorValueChangedBlock = ^(NSString *qderror) {
        if (weakself.QDerrorValueChangedBlock) {
            weakself.QDerrorValueChangedBlock(qderror);
        }
    };
    [self.itemParamSCview addSubview:_qdCurrentAssView];
    
    _harmAssView = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([BD_DifferHarmAssessmentView class]) owner:nil options:nil].lastObject;
    _harmAssView.backgroundColor = ClearColor;
    [self.itemParamSCview addSubview:_harmAssView];
    
    _actionTimeAssView = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([BD_DifferActionTimeAssessmentView class]) owner:nil options:nil].lastObject;
    _actionTimeAssView.backgroundColor = ClearColor;
    [self.itemParamSCview addSubview:_actionTimeAssView];
    self.itemParamSCview.backgroundColor = ClearColor;
    
}


-(void)testItemAssessmenViewWithIndex:(NSInteger)index{
    self.itemParamSCview.contentOffset = CGPointMake(self.itemParamSCview.frame.size.width*index, 0);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self endEditing:YES];
}

-(void)endEditing{
    [self endEditing:YES];
}

-(void)setDataToQDAssessmentViewWithError:(NSString *)error Ir:(NSString *)Ir Id_QD_SD:(NSString *)Id_QD_SD rate:(NSString *)rate rateLabel:(NSString *)rateLabel itemType:(DifferTestItemType)itemType {
    _qdCurrentAssView.testType = itemType;
    [_qdCurrentAssView setViewDataWithError:error Ir:Ir Id_QD_SD:Id_QD_SD rate:rate rateLabel:rateLabel];
    
}

-(void)setDataToHarmAssessmentViewWithData:(BD_DifferAssessmentModel *)viewData{
    _harmAssView.viewData = viewData;
    [_harmAssView setViewData];
}
-(void)setDataToActionTimeAssessmentViewWithData:(BD_DifferAssessmentModel *)viewData{
    _actionTimeAssView.viewData = viewData;
    [_actionTimeAssView setViewData];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
