//
//  BD_QuickTestActionResultView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/18.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_ActionResultView.h"
#import "UILabel+Extension.h"
@interface BD_ActionResultView()
@property(nonatomic,strong)UILabel *backValueLabel;
@property(nonatomic,strong)UILabel *backValue;
@property(nonatomic,strong)UILabel *backTimeLabel;
@property(nonatomic,strong)UILabel *backTimeValue;
@property (nonatomic,weak)UILabel *actionTimeLabel;
@property (nonatomic,strong)UILabel *actionTimeValue;
@property (nonatomic,strong)UILabel *actionValueLabel;
@property (nonatomic,strong)UILabel *actionValue;
@end

@implementation BD_ActionResultView

-(instancetype)initWithFrame:(CGRect)frame{
   self = [super initWithFrame:frame];
    if (self) {
       
       [self congigViewUI];
    }
    return self;
    
}

-(void)layoutSubviews{
     CGFloat btnY1 = self.height/2-40;
      [_actionTimeLabel setFrame:CGRectMake(5, btnY1, 90, 35)];
      [_actionTimeValue setFrame:CGRectMake(_actionTimeLabel.width, btnY1, 100, 35)];
    [_actionValueLabel setFrame:CGRectMake(_actionTimeValue.x+_actionTimeValue.width+5, btnY1, 80, 35)];
    [_actionValue setFrame:CGRectMake(_actionValueLabel.width+_actionValueLabel.x, btnY1, 100, 35)];
    [_backTimeLabel setFrame:CGRectMake(5,_actionTimeLabel.y+_actionTimeLabel.height+10, 90, 35)];
    [_backTimeValue setFrame:CGRectMake(_backTimeLabel.width, _actionTimeLabel.y+_actionTimeLabel.height+10, 100, 35)];
    [_backValueLabel setFrame:CGRectMake(_backTimeValue.x+_backTimeValue.width+5, _actionTimeLabel.y+_actionTimeLabel.height+10, 80, 35)];
    [_backValue setFrame:CGRectMake(_backValueLabel.width+_backValueLabel.x, _actionTimeLabel.y+_actionTimeLabel.height+10, 100, 35)];
}

-(void)congigViewUI{
    self.backgroundColor = BtnViewBorderColor;
    
//    //开入量A~H按钮表示
//    NSArray *btnArray1 = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H"];
//    CGFloat btnX1 = (self.width/2- btnArray1.count * 30) / 9;
//    CGFloat btnY1 = self.height/2-40;
//    CGFloat btnW = 30;
//    CGFloat btnH = 30;
//
//    for (NSInteger i = 0; i < btnArray1.count; i++) {
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setTitle:btnArray1[i] forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        btn.backgroundColor = RGB(234, 234, 234);
//        btn.tag = i+1;
//        btn.frame = CGRectMake(btnX1 + i * (btnW + btnX1), btnY1, btnW, btnH);
//        [self addSubview:btn];
//        [self.btnsArray1 addObject:btn];
//    }
//
//    //开出量 1--8按钮表示
//    NSArray *btnArray2 = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8"];
//    CGFloat btnX2 = (self.width/2 - btnArray2.count * 30) / 9;
//    CGFloat btnY2 = self.height/2;
//
//
//    for (NSInteger i = 0; i < btnArray2.count; i++) {
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setTitle:btnArray2[i] forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        btn.backgroundColor = RGB(234, 234, 234);
//        btn.tag = i*10+1;
//        btn.frame = CGRectMake(btnX2 + i * (btnW + btnX2), btnY2, btnW, btnH);
//        [self addSubview:btn];
//        [self.btnsArray2 addObject:btn];
//    }
//
    //测试结果view
   
    UIView *resultView = [[UIView alloc]init];
    [resultView setFrame: CGRectZero];
    UILabel *actionTimeLabel = [UILabel labelWithText:@"动作时间(s)" textColor:Black fontSize:14 alignment:NSTextAlignmentLeft sizeToFit:YES];
    [actionTimeLabel setFrame:CGRectZero];
    _actionTimeLabel = actionTimeLabel;
   
    _actionTimeValue = [UILabel labelWithText:@"0.000" textColor:Black fontSize:14 alignment:NSTextAlignmentLeft sizeToFit:YES];
    [_actionTimeValue setFrame:CGRectZero];
    _actionTimeValue.layer.borderWidth = 1.0;
    _actionTimeValue.layer.cornerRadius = 5;
    _actionTimeValue.layer.masksToBounds = YES;
    _actionTimeValue.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [resultView addSubview:actionTimeLabel];
    [resultView addSubview:_actionTimeValue];
    
    _actionValueLabel =  [UILabel labelWithText:@"动作值(V):" textColor:Black fontSize:14 alignment:NSTextAlignmentLeft sizeToFit:YES];
    [_actionValueLabel setFrame:CGRectZero];
    _actionValue = [UILabel labelWithText:@"0.000" textColor:Black fontSize:14 alignment:NSTextAlignmentLeft sizeToFit:YES];
    [_actionValue setFrame:CGRectZero];
    _actionValue.layer.borderWidth = 1.0;
    _actionValue.layer.cornerRadius = 5;
    _actionValue.layer.masksToBounds = YES;
    _actionValue.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [resultView addSubview:_actionValueLabel];
    [resultView addSubview:_actionValue];
    
    _backTimeLabel = [UILabel labelWithText:@"返回时间(s)" textColor:Black fontSize:14 alignment:NSTextAlignmentLeft sizeToFit:YES];
    [_backTimeLabel setFrame:CGRectZero];
    _backTimeValue = [UILabel labelWithText:@"0.000" textColor:Black fontSize:14 alignment:NSTextAlignmentLeft sizeToFit:YES];
    [_backTimeValue setFrame:CGRectZero];
    _backTimeValue.layer.borderWidth = 1.0;
    _backTimeValue.layer.cornerRadius = 5;
    _backTimeValue.layer.masksToBounds = YES;
    _backTimeValue.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [resultView addSubview:_backTimeLabel];
    [resultView addSubview:_backTimeValue];
    
    _backValueLabel =  [UILabel labelWithText:@"返回值(V):" textColor:Black fontSize:14 alignment:NSTextAlignmentLeft sizeToFit:YES];
    [_backValueLabel setFrame:CGRectZero];
    _backValue = [UILabel labelWithText:@"0.000" textColor:Black fontSize:14 alignment:NSTextAlignmentLeft sizeToFit:YES];
    [_backValue setFrame:CGRectZero];
    _backValue.layer.borderWidth = 1.0;
    _backValue.layer.cornerRadius = 5;
    _backValue.layer.masksToBounds = YES;
    _backValue.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [resultView addSubview:_backValueLabel];
    [resultView addSubview:_backValue];
    
    
    
    
    
    resultView.backgroundColor = [UIColor colorWithRed:47.0/255.0 green:155.0/255.0 blue:253.0/253.0 alpha:1.0];
    [self addSubview:resultView];
    
    [self setBackViewsShow:0];

}


-(void)setValues:( NSString * _Nullable )actionTime actionValue:(NSString * _Nullable)actionValue backTime:(NSString * _Nullable)backTime backValue:(NSString * _Nullable)backValue{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (actionTime) {
            _actionTimeValue.text = actionTime;
        }
        if (actionValue) {
            _actionValue.text = actionValue;
        }
        if (backTime) {
            _backTimeValue.text = backTime;
        }
        if (backValue) {
            _backValue.text = backValue;
        }
    });
  
}


-(void)setBackViewsShow:(int)autoChangeStyle{
    if (autoChangeStyle == 0) {
        _backValueLabel.hidden = YES;
        _backValue.hidden = YES;
        _backTimeLabel.hidden = YES;
        _backTimeValue.hidden = YES;
    } else {
        _backValueLabel.hidden = NO;
        _backValue.hidden = NO;
        _backTimeLabel.hidden = NO;
        _backTimeValue.hidden = NO;
    }
    
}

-(void)setValuesUnitWithStr:(NSString *)str{
    
    if ([str containsString:@"幅值"]) {
        if ([str hasPrefix:@"U"]) {
            _actionValueLabel.text = @"动作值(V):";
            _backValueLabel.text = @"返回值(V):";
        }
        if ([str hasPrefix:@"I"]){
            _actionValueLabel.text = @"动作值(A):";
            _backValueLabel.text = @"返回值(A):";
            
        }
    } else if ([str containsString:@"相位"]){
        _actionValueLabel.text = @"动作值(°):";
        _backValueLabel.text = @"返回值(°):";
    } else if ([str containsString:@"频率"]){
        _actionValueLabel.text = @"动作值(Hz):";
        _backValueLabel.text = @"返回值(Hz):";
    } else {
        _actionValueLabel.text = @"动作值(V):";
        _backValueLabel.text = @"返回值(V):";
    }
    
}

-(NSString *)getActionValue{
    return _actionValue.text;
}
-(NSString *)getactionTime{
    return _actionTimeValue.text;
}
-(NSString *)getBackTime{
    return _backTimeValue.text;
}
-(NSString *)getBackValue{
    return _backValue.text;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
