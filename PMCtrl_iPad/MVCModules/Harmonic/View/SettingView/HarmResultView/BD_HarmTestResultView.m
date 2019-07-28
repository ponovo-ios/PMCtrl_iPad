//
//  BD_HarmTestResultView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/19.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_HarmTestResultView.h"
#import "UILabel+Extension.h"
@interface BD_HarmTestResultView()
@property(nonatomic,strong)UILabel *backValueLabel;
@property(nonatomic,strong)UILabel *backValue;
@property(nonatomic,strong)UILabel *backTimeLabel;
@property(nonatomic,strong)UILabel *backTimeValue;

@property (nonatomic,strong)UILabel *actionTimeValue;
@property (nonatomic,strong)UILabel *actionValueLabel;
@property (nonatomic,strong)UILabel *actionValue;
@end
@implementation BD_HarmTestResultView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self congigViewUI];
    }
    return self;
    
}

-(void)congigViewUI{
    
    UILabel *title = [UILabel labelWithText:@"测试结果：" textColor:White fontSize:17 alignment:NSTextAlignmentLeft sizeToFit:YES];
    [title setFrame:CGRectMake(5,10, 90, 35)];
   
    
    [self addSubview:title];
    
    UILabel *actionTimeLabel = [UILabel labelWithText:@"动作时间(s)" textColor:White fontSize:17 alignment:NSTextAlignmentLeft sizeToFit:YES];
    [actionTimeLabel setFrame:CGRectMake(5,title.bottom+10,110, 35)];
    _actionTimeValue = [UILabel labelWithText:@"0.000" textColor:White fontSize:17 alignment:NSTextAlignmentLeft sizeToFit:YES];
    [_actionTimeValue setFrame:CGRectMake(actionTimeLabel.width,title.bottom+10, 130, 35)];
    _actionTimeValue.layer.borderWidth = 1.0;
    _actionTimeValue.layer.cornerRadius = 5;
    _actionTimeValue.layer.masksToBounds = YES;
    _actionTimeValue.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [self addSubview:actionTimeLabel];
    [self addSubview:_actionTimeValue];
    
    _actionValueLabel =  [UILabel labelWithText:@"动作值(V):" textColor:White fontSize:17 alignment:NSTextAlignmentLeft sizeToFit:YES];
    [_actionValueLabel setFrame:CGRectMake(_actionTimeValue.x+_actionTimeValue.width+5,title.bottom+10, 90, 35)];
    _actionValue = [UILabel labelWithText:@"0.000" textColor:White fontSize:17 alignment:NSTextAlignmentLeft sizeToFit:YES];
    [_actionValue setFrame:CGRectMake(_actionValueLabel.width+_actionValueLabel.x,title.bottom+10, 130, 35)];
    _actionValue.layer.borderWidth = 1.0;
    _actionValue.layer.cornerRadius = 5;
    _actionValue.layer.masksToBounds = YES;
    _actionValue.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [self addSubview:_actionValueLabel];
    [self addSubview:_actionValue];
    
    _backTimeLabel = [UILabel labelWithText:@"返回时间(s)" textColor:White fontSize:17 alignment:NSTextAlignmentLeft sizeToFit:YES];
    [_backTimeLabel setFrame:CGRectMake(5,actionTimeLabel.y+actionTimeLabel.height+10,110, 35)];
    _backTimeValue = [UILabel labelWithText:@"0.000" textColor:White fontSize:17 alignment:NSTextAlignmentLeft sizeToFit:YES];
    [_backTimeValue setFrame:CGRectMake(_backTimeLabel.width, actionTimeLabel.y+actionTimeLabel.height+10,130, 35)];
    _backTimeValue.layer.borderWidth = 1.0;
    _backTimeValue.layer.cornerRadius = 5;
    _backTimeValue.layer.masksToBounds = YES;
    _backTimeValue.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [self addSubview:_backTimeLabel];
    [self addSubview:_backTimeValue];
    
    _backValueLabel =  [UILabel labelWithText:@"返回值(V):" textColor:White fontSize:17 alignment:NSTextAlignmentLeft sizeToFit:YES];
    [_backValueLabel setFrame:CGRectMake(_backTimeValue.x+_backTimeValue.width+5, actionTimeLabel.y+actionTimeLabel.height+10, 90, 35)];
    _backValue = [UILabel labelWithText:@"0.000" textColor:White fontSize:17 alignment:NSTextAlignmentLeft sizeToFit:YES];
    [_backValue setFrame:CGRectMake(_backValueLabel.width+_backValueLabel.x, actionTimeLabel.y+actionTimeLabel.height+10, 130, 35)];
    _backValue.layer.borderWidth = 1.0;
    _backValue.layer.cornerRadius = 5;
    _backValue.layer.masksToBounds = YES;
    _backValue.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [self addSubview:_backValueLabel];
    [self addSubview:_backValue];
    
    [self setBackViewsShow:0];
    
}

-(void)setValues:( NSString * _Nullable )actionTime actionValue:(NSString * _Nullable)actionValue backTime:(NSString * _Nullable)backTime backValue:(NSString * _Nullable)backValue{
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





@end
