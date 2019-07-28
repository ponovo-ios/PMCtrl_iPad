//
//  BD_HarmWaveformController.m
//  PMCtrl_iPad
//
//  Created by wanggx on 2018/1/22.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_HarmWaveformController.h"
#import "BD_HarmWaveformView.h"
#import "UIImage+Extension.h"

@interface BD_HarmWaveformController ()

/**波形一组按钮*/
@property (nonatomic, weak) UIButton *firstBtn;
/**波形二组按钮*/
@property (nonatomic, weak) UIButton *secondBtn;
/**中间波形滚动视图*/
@property (nonatomic, weak) UIScrollView *scrollView;
/**第一组波形视图*/
@property (nonatomic, weak) UIView *firstView;
/**第二组波形视图*/
@property (nonatomic, weak) UIView *secondView;

/**波形视图数组*/
@property (nonatomic, strong) NSMutableArray *waveformArray;
@end

@implementation BD_HarmWaveformController

-(NSMutableArray *)waveformArray
{
    if (!_waveformArray) {
        _waveformArray = [NSMutableArray array];
    }
    return _waveformArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.layer.cornerRadius = Marge;
    
    self.view.layer.borderWidth = 1.5;
    
    self.view.layer.borderColor = ClearColor.CGColor;
    
    self.view.layer.masksToBounds = YES;
    
    //添加通知
    [kNotificationCenter addObserver:self selector:@selector(refreshWaveView:) name:BD_HarmWaveformRefresh object:nil];

    [self configureUI];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGFloat h = Main_Screen_Height - 64 - 60 - 80 - 50;
    CGFloat w = Main_Screen_Width - 20 - 80;

    [self.firstView setFrame:CGRectMake(0, 0, w, h)];
    [self.secondView setFrame:CGRectMake(w, 0, w, h)];
}
-(void)configureUI
{
    //头部视图
    UIView *headerView = [[UIView alloc] init];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    
    //切换按钮
    UIButton *firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    firstBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [firstBtn setTitle:@"波形图一组" forState:UIControlStateNormal];
    [firstBtn setBackgroundImage:[UIImage imageWithColor:RGB(219, 219, 219) width:100 height:50 title:@""] forState:UIControlStateSelected];
    [firstBtn setBackgroundImage:[UIImage imageWithColor:MainBgColor width:150 height:50 title:@""] forState:UIControlStateNormal];
    [firstBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [firstBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [headerView addSubview:firstBtn];
    [firstBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.bottom.mas_equalTo(0);
        make.width.mas_equalTo(150);
    }];
    self.firstBtn = firstBtn;
    
    UIButton *secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    secondBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [secondBtn setTitle:@"波形图二组" forState:UIControlStateNormal];
    [secondBtn setBackgroundImage:[UIImage imageWithColor:RGB(219, 219, 219) width:150 height:50 title:@""] forState:UIControlStateSelected];
    [secondBtn setBackgroundImage:[UIImage imageWithColor:MainBgColor width:100 height:50 title:@""] forState:UIControlStateNormal];
    [secondBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [secondBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [headerView addSubview:firstBtn];
    [headerView addSubview:secondBtn];
    [secondBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.mas_equalTo(0);
        make.left.mas_equalTo(firstBtn.mas_right);
        make.width.mas_equalTo(150);
    }];
    self.secondBtn = secondBtn;
    
    [firstBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [secondBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //中部滚动视图
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = RGB(219, 219, 219);
    scrollView.scrollEnabled = NO;
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.and.right.mas_equalTo(0);
        make.top.mas_equalTo(headerView.mas_bottom);
    }];
    self.scrollView = scrollView;
    
    //波形视图
    CGFloat h = Main_Screen_Height - 64 - 60 - 80 - 50;
    CGFloat w = Main_Screen_Width - 20 - 80;
    
    UIView *firstV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
//    firstV.backgroundColor = [UIColor redColor];
    [scrollView addSubview:firstV];
    self.firstView = firstV;
    
    UIView *secondV = [[UIView alloc] initWithFrame:CGRectMake(w, 0, w, h)];
//    secondV.backgroundColor = [UIColor yellowColor];
    [scrollView addSubview:secondV];
    self.secondView = secondV;

}

-(void)setupWaveformWithFirstView:(UIView *)firstView secondView:(UIView *)secondView
{
    if (self.firstView && self.secondView) {
        CGFloat h = (firstView.height - 30) * 0.5;
        //清除子视图
        [self.waveformArray removeAllObjects];
        [self.firstView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.secondView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        if (self.harmModel.testType == SIMULATION_TYPE) {//模拟
            if (self.harmModel.testChannel == F_U_T_I) {//4U3I
                //第一组波形视图
                BD_HarmWaveformView *v = [[BD_HarmWaveformView alloc] initWithFrame:CGRectMake(Marge, Marge, firstView.width - 20, h) type:WAVEFORM_S_V];
                //设置数据
                v.tableModel = (BD_HarmTableDataModel *)self.harmModel.allDataArray.firstObject;
                v.channelArray = self.harmModel.passagewayArray;
                v.fre = self.harmModel.dataModel.fre;
                v.dcDataArray = @[self.harmModel.dcSettingModel.ua, self.harmModel.dcSettingModel.ub, self.harmModel.dcSettingModel.uc, self.harmModel.dcSettingModel.uz];
                [firstView addSubview:v];
                [v drawWaveformLine];
                [self.waveformArray addObject:v];
                
                BD_HarmWaveformView *v2 = [[BD_HarmWaveformView alloc] initWithFrame:CGRectMake(Marge, CGRectGetMaxY(v.frame) + Marge, firstView.width - 20, h) type:WAVEFORM_S_C];
                v2.tableModel = (BD_HarmTableDataModel *)self.harmModel.allDataArray.lastObject;
                v2.channelArray = self.harmModel.passagewayArray;
                v2.fre = self.harmModel.dataModel.fre;
                v2.dcDataArray = @[self.harmModel.dcSettingModel.ia, self.harmModel.dcSettingModel.ib, self.harmModel.dcSettingModel.ic];
                [firstView addSubview:v2];
                [v2 drawWaveformLine];
                [self.waveformArray addObject:v2];
                
            }else{//6U6I
                //第一组波形视图
                BD_HarmWaveformView *v = [[BD_HarmWaveformView alloc] initWithFrame:CGRectMake(Marge, Marge, firstView.width - 20, h) type:WAVEFORM_S_V1];
                v.tableModel = (BD_HarmTableDataModel *)self.harmModel.allDataArray.firstObject;
                v.channelArray = self.harmModel.passagewayArray;
                v.fre = self.harmModel.dataModel.fre;
                v.dcDataArray = @[self.harmModel.dcSettingModel.ua, self.harmModel.dcSettingModel.ub, self.harmModel.dcSettingModel.uc];
                [firstView addSubview:v];
                [v drawWaveformLine];
                [self.waveformArray addObject:v];
                
                BD_HarmWaveformView *v2 = [[BD_HarmWaveformView alloc] initWithFrame:CGRectMake(Marge, CGRectGetMaxY(v.frame) + Marge, firstView.width - 20, h) type:WAVEFORM_S_C1];
                v2.tableModel = (BD_HarmTableDataModel *)self.harmModel.allDataArray[1];
                v2.channelArray = self.harmModel.passagewayArray;
                v2.fre = self.harmModel.dataModel.fre;
                v2.dcDataArray = @[self.harmModel.dcSettingModel.ia, self.harmModel.dcSettingModel.ib, self.harmModel.dcSettingModel.ic];
                [firstView addSubview:v2];
                [v2 drawWaveformLine];
                [self.waveformArray addObject:v2];
                
                //第二组波形视图
                BD_HarmWaveformView *v3 = [[BD_HarmWaveformView alloc] initWithFrame:CGRectMake(Marge, Marge, firstView.width - 20, h) type:WAVEFORM_S_V2];
                v3.tableModel = (BD_HarmTableDataModel *)self.harmModel.allDataArray[2];
                v3.channelArray = self.harmModel.passagewayArray;
                v3.fre = self.harmModel.dataModel.fre;
                v3.dcDataArray = @[self.harmModel.dcSettingModel.ua2, self.harmModel.dcSettingModel.ub2, self.harmModel.dcSettingModel.uc2];
                [secondView addSubview:v3];
                [v3 drawWaveformLine];
                [self.waveformArray addObject:v3];
                
                BD_HarmWaveformView *v4 = [[BD_HarmWaveformView alloc] initWithFrame:CGRectMake(Marge, CGRectGetMaxY(v3.frame) + Marge, firstView.width - 20, h) type:WAVEFORM_S_C2];
                v4.tableModel = (BD_HarmTableDataModel *)self.harmModel.allDataArray.lastObject;
                v4.channelArray = self.harmModel.passagewayArray;
                v4.fre = self.harmModel.dataModel.fre;
                v4.dcDataArray = @[self.harmModel.dcSettingModel.ia2, self.harmModel.dcSettingModel.ib2, self.harmModel.dcSettingModel.ic2];
                [secondView addSubview:v4];
                [v4 drawWaveformLine];
                [self.waveformArray addObject:v4];
            }
        }else{//数字
            if (self.harmModel.testChannel == F_U_T_I) {//4U3I
                //第一组波形视图
                BD_HarmWaveformView *v = [[BD_HarmWaveformView alloc] initWithFrame:CGRectMake(Marge, Marge, firstView.width - 20, h) type:WAVEFORM_N_V];
                v.tableModel = (BD_HarmTableDataModel *)self.harmModel.allDataArray.firstObject;
                v.channelArray = self.harmModel.passagewayArray;
                v.fre = self.harmModel.dataModel.fre;
                v.dcDataArray = @[self.harmModel.dcSettingModel.ua, self.harmModel.dcSettingModel.ub, self.harmModel.dcSettingModel.uc, self.harmModel.dcSettingModel.uz];
                [firstView addSubview:v];
                [v drawWaveformLine];
                [self.waveformArray addObject:v];
                
                BD_HarmWaveformView *v2 = [[BD_HarmWaveformView alloc] initWithFrame:CGRectMake(Marge, CGRectGetMaxY(v.frame) + Marge, firstView.width - 20, h) type:WAVEFORM_N_C];
                v2.tableModel = (BD_HarmTableDataModel *)self.harmModel.allDataArray.lastObject;
                v2.channelArray = self.harmModel.passagewayArray;
                v2.fre = self.harmModel.dataModel.fre;
                v2.dcDataArray = @[self.harmModel.dcSettingModel.ia, self.harmModel.dcSettingModel.ib, self.harmModel.dcSettingModel.ic];
                [firstView addSubview:v2];
                [v2 drawWaveformLine];
                [self.waveformArray addObject:v2];
                
            }else{//6U6I
                //第一组波形视图
                BD_HarmWaveformView *v = [[BD_HarmWaveformView alloc] initWithFrame:CGRectMake(Marge, Marge, firstView.width - 20, h) type:WAVEFORM_N_V1];
                v.tableModel = (BD_HarmTableDataModel *)self.harmModel.allDataArray.firstObject;
                v.channelArray = self.harmModel.passagewayArray;
                v.fre = self.harmModel.dataModel.fre;
                v.dcDataArray = @[self.harmModel.dcSettingModel.ua, self.harmModel.dcSettingModel.ub, self.harmModel.dcSettingModel.uc];
                [firstView addSubview:v];
                [v drawWaveformLine];
                [self.waveformArray addObject:v];
                
                BD_HarmWaveformView *v2 = [[BD_HarmWaveformView alloc] initWithFrame:CGRectMake(Marge, CGRectGetMaxY(v.frame) + Marge, firstView.width - 20, h) type:WAVEFORM_N_C1];
                v2.tableModel = (BD_HarmTableDataModel *)self.harmModel.allDataArray[1];
                v2.channelArray = self.harmModel.passagewayArray;
                v2.fre = self.harmModel.dataModel.fre;
                v2.dcDataArray = @[self.harmModel.dcSettingModel.ia, self.harmModel.dcSettingModel.ib, self.harmModel.dcSettingModel.ic];
                [firstView addSubview:v2];
                [v2 drawWaveformLine];
                [self.waveformArray addObject:v2];
                
                //第二组波形视图
                BD_HarmWaveformView *v3 = [[BD_HarmWaveformView alloc] initWithFrame:CGRectMake(Marge, Marge, firstView.width - 20, h) type:WAVEFORM_N_V2];
                v3.tableModel = (BD_HarmTableDataModel *)self.harmModel.allDataArray[2];
                v3.channelArray = self.harmModel.passagewayArray;
                v3.fre = self.harmModel.dataModel.fre;
                v3.dcDataArray = @[self.harmModel.dcSettingModel.ua2, self.harmModel.dcSettingModel.ub2, self.harmModel.dcSettingModel.uc2];
                [secondView addSubview:v3];
                [v3 drawWaveformLine];
                [self.waveformArray addObject:v3];
                
                BD_HarmWaveformView *v4 = [[BD_HarmWaveformView alloc] initWithFrame:CGRectMake(Marge, CGRectGetMaxY(v3.frame) + Marge, firstView.width - 20, h) type:WAVEFORM_N_C2];
                v4.tableModel = (BD_HarmTableDataModel *)self.harmModel.allDataArray.lastObject;
                v4.channelArray = self.harmModel.passagewayArray;
                v4.fre = self.harmModel.dataModel.fre;
                v4.dcDataArray = @[self.harmModel.dcSettingModel.ia2, self.harmModel.dcSettingModel.ib2, self.harmModel.dcSettingModel.ic2];
                [secondView addSubview:v4];
                [v4 drawWaveformLine];
                [self.waveformArray addObject:v4];
            }
        }
        
        
    }
    
}

-(void)setHarmModel:(BD_HarmModel *)harmModel
{
    _harmModel = harmModel;
    
    if (harmModel.testChannel == F_U_T_I) {
        self.secondBtn.hidden = YES;
        [self btnClick:self.firstBtn];
        self.scrollView.contentSize = CGSizeMake(self.scrollView.width, 0);
    }else{
        self.secondBtn.hidden = NO;
        [self btnClick:self.firstBtn];
        self.scrollView.contentSize = CGSizeMake(self.scrollView.width * 2, 0);
    }
    
    if (self.waveformArray.count == 0) {
        //设置波形视图
        [self setupWaveformWithFirstView:self.firstView secondView:self.secondView];
    }else{
        [self refreshWaveform];
    }
    
}

-(void)btnClick:(UIButton *)sender
{
    //点击 波形一组 按钮
    if (sender == self.firstBtn) {
        self.firstBtn.selected = YES;
        self.secondBtn.selected = NO;
        [self.scrollView setContentOffset:CGPointZero];
    }else{//点击 波形二组 按钮
        self.secondBtn.selected = YES;
        self.firstBtn.selected = NO;
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.width, 0)];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//刷新波形
-(void)refreshWaveform
{
    if (self.harmModel == nil) {
        return;
    }
        NSMutableArray *dcArray = [NSMutableArray array];
        //直流数值
        if (self.harmModel.testChannel == F_U_T_I) {//4U3I
            [dcArray addObject:@[self.harmModel.dcSettingModel.ua, self.harmModel.dcSettingModel.ub, self.harmModel.dcSettingModel.uc, self.harmModel.dcSettingModel.uz]];
            [dcArray addObject:@[self.harmModel.dcSettingModel.ia, self.harmModel.dcSettingModel.ib, self.harmModel.dcSettingModel.ic]];
        }else{
            [dcArray addObject:@[self.harmModel.dcSettingModel.ua, self.harmModel.dcSettingModel.ub, self.harmModel.dcSettingModel.uc]];
            [dcArray addObject:@[self.harmModel.dcSettingModel.ia, self.harmModel.dcSettingModel.ib, self.harmModel.dcSettingModel.ic]];
            [dcArray addObject:@[self.harmModel.dcSettingModel.ua2, self.harmModel.dcSettingModel.ub2, self.harmModel.dcSettingModel.uc2]];
            [dcArray addObject:@[self.harmModel.dcSettingModel.ia2, self.harmModel.dcSettingModel.ib2, self.harmModel.dcSettingModel.ic2]];
        }
        
        for (NSInteger i = 0; i < self.waveformArray.count; i++) {
            BD_HarmWaveformView *view = self.waveformArray[i];
            view.fre = self.harmModel.dataModel.fre;
            view.dcDataArray = dcArray[i];
            
            [view refreshWaveformData];
        }

    
}
-(void)refreshWaveView:(NSNotification *)noti{
    [self refreshWaveform];
}

/**重汇波形*/
-(void)drawWaveformLine:(BD_HarmModel *)harmModel
{
    [self.waveformArray removeAllObjects];
    [self setHarmModel:harmModel];
}


-(void)dealloc
{
    [kNotificationCenter removeObserver:self name:BD_HarmWaveformRefresh object:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
