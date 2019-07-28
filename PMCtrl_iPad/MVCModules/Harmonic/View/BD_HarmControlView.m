
//
//  BD_HarmControlView.m
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/11/28.
//  Copyright © 2017年 ponovo. All rights reserved.
//  顶部控制台视图

#import "BD_HarmControlView.h"
#import "UIImage+Extension.h"

@interface BD_HarmControlView()

/**<#Description#>*/
@property (nonatomic, weak) UIView *dataView;

/**数据视图*/
@property (nonatomic, weak) UIButton *dataBtn;

/**波形视图*/
@property (nonatomic, weak) UIButton *harmBtn;
/**信息图*/
@property (nonatomic, weak) UIButton *infoBtn;
/**锁定按钮*/
@property (nonatomic, weak) UIButton *lockBtn;
@end

@implementation BD_HarmControlView


-(instancetype)init
{
    if (self = [super init]) {
        
        [self configureUI];
        
    }
    
    return self;
}

//初始化布局
-(void)configureUI
{
    
    self.backgroundColor = MainBgColor;
    
    [self setupDataView];
    
    [self setupPlayView];
    
    /*
    NSArray *titleArray = @[@"开始测试", @"停止测试", @"数据视图", @"波形视图"];
    
    CGFloat btnX = 5;
    CGFloat btnY = 5;
    CGFloat btnW = (Main_Screen_Width * 0.5 - 25) / titleArray.count;
    CGFloat btnH = 40;
    
    for (NSInteger i = 0; i < titleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor lightGrayColor];
        button.layer.cornerRadius = 5;
        button.frame = CGRectMake((btnX + btnW) * i + btnX, btnY, btnW, btnH);
        [self addSubview:button];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
     */
    
}

-(void)setupDataView
{
    //切换 数据/波形
    UIView *dataView = [[UIView alloc] init];
    dataView.layer.cornerRadius = Marge;
    dataView.layer.borderWidth = 1.5;
    dataView.layer.borderColor = BtnViewBorderColor.CGColor;
    [self addSubview:dataView];
    [dataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(-5);
        make.width.mas_equalTo(Main_Screen_Width * 0.3);
    }];
    self.dataView = dataView;
    
    CGFloat btnW = (Main_Screen_Width * 0.3 - 20)/3;
    CGFloat btnH = 30;
    
    //数据视图按钮
    UIButton *dataBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dataBtn.tag = 1;
    [dataBtn setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor] width:btnW height:btnH title:@""] forState:UIControlStateNormal];
    [dataBtn setBackgroundImage:[UIImage imageWithColor:RGB(0, 134, 146) width:btnW height:btnH title:@""] forState:UIControlStateSelected];
    [dataBtn setTitle:@"数据视图" forState:UIControlStateNormal];
    dataBtn.layer.cornerRadius = 5;
    dataBtn.layer.masksToBounds = YES;
    [dataView addSubview:dataBtn];
    [dataBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(-5);
        make.width.mas_equalTo(btnW);
    }];
    [dataBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.dataBtn = dataBtn;
    //默认显示数据视图
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [weakSelf btnClick:dataBtn];
    });
   
    
    //谐波视图按钮
    UIButton *harmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    harmBtn.tag = 2;
    [harmBtn setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor] width:btnW height:btnH title:@""] forState:UIControlStateNormal];
    [harmBtn setBackgroundImage:[UIImage imageWithColor:RGB(0, 134, 146) width:btnW height:btnH title:@""] forState:UIControlStateSelected];
    [harmBtn setTitle:@"波形视图" forState:UIControlStateNormal];
    harmBtn.layer.cornerRadius = 5;
    harmBtn.layer.masksToBounds = YES;
    [dataView addSubview:harmBtn];
    [harmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(dataBtn.mas_right).offset(5);
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(-5);
        make.width.mas_equalTo(btnW);
    }];
    [harmBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.harmBtn = harmBtn;
    
    //信息图按钮
    UIButton *infoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    infoBtn.tag = 5;
    [infoBtn setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor] width:btnW height:btnH title:@""] forState:UIControlStateNormal];
    [infoBtn setBackgroundImage:[UIImage imageWithColor:RGB(0, 134, 146) width:btnW height:btnH title:@""] forState:UIControlStateSelected];
    [infoBtn setTitle:@"信息图" forState:UIControlStateNormal];
    infoBtn.layer.cornerRadius = 5;
    infoBtn.layer.masksToBounds = YES;
    [dataView addSubview:infoBtn];
    [infoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(harmBtn.mas_right).offset(5);
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(-5);
        make.width.mas_equalTo(btnW);
    }];
    [infoBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.infoBtn = infoBtn;
    
}

-(void)setupPlayView
{
    //切换 开始/停止
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = 3;
    [button setImage:[UIImage imageNamed:@"rightBtn4"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"rightBtnStop"] forState:UIControlStateSelected];
    button.backgroundColor = [UIColor lightGrayColor];
    button.layer.cornerRadius = Marge;
    button.layer.borderWidth = 1.5;
    button.layer.borderColor = BtnViewBorderColor.CGColor;
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.dataView);
        make.left.mas_equalTo(self.dataView.mas_right).offset(Marge);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(129 * 50 / 134);
    }];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.startBtn = button;
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.tag = 4;
    [button1 setImage:[UIImage imageNamed:@"lock_unused"] forState:UIControlStateNormal];
    [button1 setImage:[UIImage imageNamed:@"lockOpen"] forState:UIControlStateSelected];
    //lock_unused 按钮不可用
    button1.backgroundColor = [UIColor lightGrayColor];
    button1.userInteractionEnabled = NO;
    button1.layer.cornerRadius = Marge;
    button1.layer.borderWidth = 1.5;
    button1.layer.borderColor = BtnViewBorderColor.CGColor;
    [self addSubview:button1];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.dataView);
        make.left.mas_equalTo(button.mas_right).offset(Marge);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(129 * 50 / 134);
    }];
    [button1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.lockBtn = button1;
    
}

-(void)btnClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 1:
            sender.selected = YES;
            self.harmBtn.selected = NO;
            self.infoBtn.selected = NO;
            break;
        case 2:
            sender.selected = YES;
            self.dataBtn.selected = NO;
            self.infoBtn.selected = NO;
            break;
        case 3:
            //开始
            sender.selected = !sender.selected;
            break;
        case 4:
            //锁定
            sender.selected = !sender.selected;
            break;
        case 5:
            //信息图
            sender.selected = YES;
            self.harmBtn.selected = NO;
            self.dataBtn.selected = NO;
            break;
        default:
            break;
    }
    [self.delegate didSelectedButton:sender];
}

- (void)drawRect:(CGRect)rect {
    
}

-(void)setLockBtnIsUsed:(BOOL)isUsed{
    if (isUsed) {
          [self.lockBtn setImage:[UIImage imageNamed:@"rightBtn3"] forState:UIControlStateNormal];
        self.lockBtn.userInteractionEnabled = YES;
    } else {
        [self.lockBtn setImage:[UIImage imageNamed:@"lock_unused"] forState:UIControlStateNormal];
        self.lockBtn.userInteractionEnabled = NO;
    }
}

@end
