//
//  BD_HarmSwitchView.m
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/11/28.
//  Copyright © 2017年 ponovo. All rights reserved.
//  底部开关量视图

#import "BD_BinarySwitchView.h"

@implementation BD_BinarySwitchView

-(instancetype)initWithTitleArray:(NSArray *)array
{
    if (self = [super init]) {
        [self configureUIWithTitleArray:array];
    }
    return self;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        [self configureUI];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat btnX = 5;
    CGFloat btnW = (Main_Screen_Width - 40 - (_switchBtnArr.count + 1) * 5) / _switchBtnArr.count;
    CGFloat btnY = (self.height-btnW)/2;
    CGFloat btnH = btnW;
    
    [_switchBtnArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         obj.frame = CGRectMake((btnX + btnW) * idx + btnX, btnY, btnW, btnH);
    }];
}
-(void)configureUI
{
    
    self.backgroundColor = MainBgColor;
    _switchBtnArr = [[NSMutableArray alloc]init];
    NSArray *titleArray = @[@"Run", @"Udc", @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"Ia", @"Ib", @"Ic", @"U", @"OH", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8",@"L1", @"L2", @"L3", @"L4", @"L5", @"L6", @"L7", @"L8"];
    
    CGFloat btnX = 2;
    CGFloat btnW = (Main_Screen_Width - 200 - (titleArray.count + 1) * btnX) / titleArray.count;
    CGFloat btnY = (self.height-btnW)/2;
    CGFloat btnH = btnW;
     NSArray *binary = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8"];
    for (NSInteger i = 0; i < titleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 200 + i;
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        button.backgroundColor = White;
        [button setTitleColor:Black forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:9];
        button.frame = CGRectMake((btnX + btnW) * i + btnX, btnY, btnW, btnH);
        
        if (![binary containsObject:titleArray[i]]) {
            [button setCorenerRadius:btnW/2 borderColor:[UIColor lightGrayColor] borderWidth:1];
        }
        [self addSubview:button];
        [_switchBtnArr addObject:button];
    }
}
-(void)configureUIWithTitleArray:(NSArray *)titleArray
{
    
    self.backgroundColor = MainBgColor;
    _switchBtnArr = [[NSMutableArray alloc]init];
    CGFloat btnX = 2;
    CGFloat btnW = (Main_Screen_Width - 200 - (titleArray.count + 1) * btnX) / titleArray.count;
      CGFloat btnY = (self.height-btnW)/2;
    CGFloat btnH = btnW;
    NSArray *binary = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8"];
    for (NSInteger i = 0; i < titleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 200 + i;
        [button setTitleColor:Black forState:UIControlStateNormal];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        button.backgroundColor = White;
        button.titleLabel.font = [UIFont systemFontOfSize:9];
        button.frame = CGRectMake((btnX + btnW) * i + btnX, btnY, btnW, btnH);
        
        if (![binary containsObject:titleArray[i]]) {
            [button setCorenerRadius:btnW/2 borderColor:[UIColor lightGrayColor] borderWidth:1];
        }
        [self addSubview:button];
        [_switchBtnArr addObject:button];
    }
   
}

- (void)drawRect:(CGRect)rect {
    
    self.layer.cornerRadius = Marge;
    
    self.layer.borderWidth = 1.5;
    
    self.layer.borderColor = BtnViewBorderColor.CGColor;
}


-(void)addCurrentLightWithGroup:(NSInteger)groupNum{
    [self.switchBtnArr removeAllObjects];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSMutableArray *currentTitle = [[NSMutableArray alloc] initWithObjects:@"Run", @"Udc", @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J",nil];
    for (NSInteger i = 0; i<groupNum; i++) {
        
        [currentTitle addObject:[NSString stringWithFormat:@"Ia%ld",i+1]];
        [currentTitle addObject:[NSString stringWithFormat:@"Ib%ld",i+1]];
        [currentTitle addObject:[NSString stringWithFormat:@"Ic%ld",i+1]];
        
        
    }
    NSArray *a =  @[@"U", @"OH", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8",@"L1", @"L2", @"L3", @"L4", @"L5", @"L6", @"L7", @"L8"];
    [currentTitle addObjectsFromArray:a];
    
    CGFloat btnX = 2;
   
    CGFloat btnW = (Main_Screen_Width - 200 - (currentTitle.count + 1) * btnX) / (currentTitle.count);
     CGFloat btnY = (self.height-btnW)/2;
    CGFloat btnH = btnW;
    NSArray *binary = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8"];
    
    for (NSInteger i = 0; i < currentTitle.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 200 + i;
        [button setTitleColor:Black forState:UIControlStateNormal];
        [button setTitle:currentTitle[i] forState:UIControlStateNormal];
        button.backgroundColor = White;
        if (![binary containsObject:currentTitle[i]]) {
            [button setCorenerRadius:btnW/2 borderColor:[UIColor lightGrayColor] borderWidth:1];
        }
        button.titleLabel.font = [UIFont systemFontOfSize:9];
        button.frame = CGRectMake((btnX + btnW) * i + btnX, btnY, btnW, btnH);
       
        [self addSubview:button];
        [_switchBtnArr addObject:button];
    }
}

@end
