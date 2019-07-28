//
//  BD_HarmSettingView.m
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/11/28.
//  Copyright © 2017年 ponovo. All rights reserved.
//  侧边设置视图

#import "BD_HarmSettingView.h"
#import "UIImage+Extension.h"
#import "BD_HarmSystemsParameterView.h"
#import "BD_HarmSwitchTableView.h"
#import "BD_HarmDCTableView.h"
#import "BD_HarmDataSettingTableView.h"
#import "BD_HarmTestResultView.h"
@interface BD_HarmSettingView()<BD_HarmSystemsParameterViewDelegate>
/**<#Description#>*/
@property (nonatomic, weak) UIScrollView *settingScrollView;
/**直流设置*/
@property (nonatomic, weak) BD_HarmDCTableView *dcTableView;
/**数据视图*/
@property (nonatomic, weak) BD_HarmDataSettingTableView *dataTableView;
/**参数设置视图*/
@property (nonatomic, weak) BD_HarmSystemsParameterView *paramsView;
/**开关量设置视图*/
@property (nonatomic, weak) BD_HarmSwitchTableView *tableView;
/**测试结果数据视图*/
@property (nonatomic, weak) BD_HarmTestResultView *resultView;
@end

@implementation BD_HarmSettingView

-(instancetype)init
{
    if (self = [super init]) {
        [self configureUI];
    }
    return self;
}

-(void)configureUI
{

    self.backgroundColor = MainBgColor;
    
    [self setupSettingButton];
    
    [self setupSettingView];
    
}

-(void)layoutSubviews{
    [self.settingScrollView setFrame:CGRectMake(70,0, self.height, self.width-70)];
    [self.dataTableView setFrame:CGRectMake(0, self.settingScrollView.height , self.settingScrollView.width, self.settingScrollView.height)];
    [self.dcTableView setFrame:CGRectMake(0, self.settingScrollView.height * 2, self.settingScrollView.width, self.settingScrollView.height)];
    self.settingScrollView.contentSize = CGSizeMake(0, 2 * self.settingScrollView.height);
    
}
//设置按钮
-(void)setupSettingButton
{
    NSArray *titleArray = @[@"数据设置", @"直流设置"];
    
    CGFloat btnX = Marge;
    CGFloat btnY = Marge;
    CGFloat btnW = 50;
    CGFloat btnH = (Main_Screen_Height * 3 / 4 - 6 * Marge) / titleArray.count;
    NSMutableArray *btnArr = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < titleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i + 100;
        button.titleLabel.lineBreakMode = 0;
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        button.layer.cornerRadius = 10;
        button.layer.masksToBounds = YES;
        [button setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor] width:btnW height:btnH title:@""] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageWithColor:RGB(0, 134, 146) width:btnW height:btnH title:@""] forState:UIControlStateSelected];
        
        button.frame = CGRectMake(btnX, (btnY + btnH) * i + btnY, btnW, btnH);
        [btnArr addObject:button];
        [self addSubview:button];
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    self.settingViewBtnArr = [btnArr copy];
}

//设置视图
-(void)setupSettingView
{
    UIScrollView *settingScrollView = [[UIScrollView alloc] init];
    settingScrollView.backgroundColor = MainBgColor;
    settingScrollView.layer.cornerRadius = Marge;
    settingScrollView.pagingEnabled = YES;
    settingScrollView.scrollEnabled = NO;
    [self addSubview:settingScrollView];
   
    self.settingScrollView = settingScrollView;
    
}

//设置子视图
-(void)setupSubView
{
  
    //数据
    BD_HarmDataSettingTableView *dataTableView = [[BD_HarmDataSettingTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.settingScrollView addSubview:dataTableView];
    self.dataTableView = dataTableView;
    
    //直流
    BD_HarmDCTableView *dcTableView = [[BD_HarmDCTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.settingScrollView addSubview:dcTableView];
    self.dcTableView = dcTableView;

}

//按钮点击
-(void)buttonClick:(UIButton *)sender
{
    [self.delegate settingButtonClick:sender];
    [self.settingScrollView setContentOffset:CGPointMake(0, (sender.tag - 100) * self.settingScrollView.height) animated:NO];
}

- (void)drawRect:(CGRect)rect {
    
    self.layer.cornerRadius = Marge;
    
    self.layer.borderWidth = 1.5;
    
    self.layer.borderColor = BtnViewBorderColor.CGColor;
    
    /*
    UIColor *color = BtnViewBorderColor;
    //设置线条颜色
    [color set];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(70, 0)];
    [path addLineToPoint:CGPointMake(10, 0)];
    [path moveToPoint:CGPointMake(10, 0)];
    [path addQuadCurveToPoint:CGPointMake(0, 10) controlPoint:CGPointMake(0, 0)];
    [path moveToPoint:CGPointMake(0, 10)];
    [path addLineToPoint:CGPointMake(0, 566)];
    [path moveToPoint:CGPointMake(0, 566)];
    [path addQuadCurveToPoint:CGPointMake(10, 576) controlPoint:CGPointMake(0, 576)];
    [path moveToPoint:CGPointMake(10, 576)];
    [path addLineToPoint:CGPointMake(70, 576)];
    
    path.lineWidth = 3.0;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    
    [path stroke];
     */
}

-(void)setHarmModel:(BD_HarmModel *)harmModel
{
    _harmModel = harmModel;
    //绑定模型
//    self.dataTableView.passagewayArray = harmModel.passagewayArray;
    self.dataTableView.harmModel = harmModel;
    self.paramsView.paramsModel = harmModel.paramsModel;
    self.tableView.switchModel = harmModel.switchModel;
    self.dcTableView.dcSettingModel = harmModel.dcSettingModel;
}


#pragma mark BD_HarmSystemsParameterViewDelegate
-(void)changedType:(NSString *)type passageway:(NSString *)passageway
{
    //改变直流设置界面
    [self.dcTableView reloadDataWithType:type passageway:passageway];
    //代理
    [self.delegate changedType:type passageway:passageway];
    //改变数据设置界面
    [self.dataTableView changedType:type passageway:passageway];
}


-(void)setResultData:( NSString * _Nullable )actionTime actionValue:(NSString * _Nullable)actionValue backTime:(NSString * _Nullable)backTime backValue:(NSString * _Nullable)backValue{
    [self.resultView setValues:actionTime actionValue:actionValue backTime:backTime backValue:backValue];
}

@end
