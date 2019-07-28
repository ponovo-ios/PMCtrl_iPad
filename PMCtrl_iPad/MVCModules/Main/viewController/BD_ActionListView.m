//
//  BD_ActionListView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/11.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_ActionListView.h"
@interface BD_ActionListView()
@property(nonatomic,strong)NSArray *actionTitles;
@property(nonatomic,strong)UIScrollView *scrollView;
@end

@implementation BD_ActionListView

-(instancetype)initWithTitles:(NSArray *)titles{
    if (self = [self init]) {
        _actionTitles = titles;
        [self loadSubViews];
    }
    return self;
}
-(void)layoutSubviews{
    _scrollView.frame = self.bounds;
    if (self.actionBtns.count*40+20>self.scrollView.height) {
        self.scrollView.contentSize = CGSizeMake(self.scrollView.width, self.actionBtns.count*40+20);
    } else {
        self.scrollView.contentSize = CGSizeMake(self.scrollView.width,self.scrollView.height);
    }
    for (NSInteger i = 0; i<_actionTitles.count; i++) {
        UIButton *button = self.actionBtns[i];
        CGFloat btnH = 35;
        CGFloat btnY = 5;
        [button setFrame:CGRectMake(10,10+i*(btnH+btnY),self.width-20,btnH)];
    }
    
    
}
-(void)loadSubViews{
    NSMutableArray *btnArr = [[NSMutableArray alloc]init];
   _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    _scrollView.backgroundColor = ClearColor;
    _scrollView.bounces = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_scrollView];
    CGFloat btnH = 35;
    CGFloat btnY = 5;
    for (NSInteger i = 0; i<_actionTitles.count; i++) {
        UIButton *button = [[UIButton alloc]init];
        [button setTitle:_actionTitles[i] forState:UIControlStateNormal];
        [button setTitleColor:White forState:UIControlStateNormal];
        [button setCorenerRadius:6.0 borderColor:BtnViewBorderColor borderWidth:2.0];
        button.tag = i;
        [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setFrame:CGRectMake(10,10+i*(btnH+btnY),self.width-20,btnH)];
        [_scrollView addSubview:button];
        [btnArr addObject:button];
    }
    self.actionBtns = [btnArr copy];
   
}

-(void)btnAction:(UIButton *)sender{
    if (self.actionIndexBlock) {
        self.actionIndexBlock(sender.tag);
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
