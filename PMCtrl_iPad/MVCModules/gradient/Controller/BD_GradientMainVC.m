//
//  BD_GradientMainVC.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/5/30.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_GradientMainVC.h"
#import "BD_BinarySwitchView.h"
#import "UIImage+Extension.h"
#import "BD_TestDataParaVC.h"
#import "BD_VectorDiagramVC.h"
#import "BD_TestItemParamModel.h"
@interface BD_GradientMainVC ()
@property(nonatomic,weak)BD_TestDataParaVC *dataParaVC;
@property(nonatomic,assign)NSInteger groupNum;
@property(nonatomic,weak)BD_VectorDiagramVC *vectorVC;
@end

@implementation BD_GradientMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.mainView.contentSize = CGSizeMake(self.mainView.width*3, self.mainView.height);
    [self.dataParaVC.view setFrame:CGRectMake(0,0, self.mainView.width, self.mainView.height)];
    [self.vectorVC.view setFrame:CGRectMake(self.mainView.width*2,0, self.mainView.width, self.mainView.height)];
}
-(void)configureUI{
    [super configureUI];
    
    self.switchView = [[BD_BinarySwitchView alloc] initWithTitleArray:@[@"Run", @"Udc", @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"Ia", @"Ib", @"Ic", @"U", @"OH", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8"]];
    [self.view addSubview:self.switchView];
    [self.switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-Marge);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(60);
    }];
    
    
    CGFloat btnX = 10;
    CGFloat btnW = 100;
    CGFloat btnH = 40;
    NSArray *btnTitle = @[@"数据",@"时间特性图",@"矢量图"];
    NSMutableArray *viewBtnArr = [[NSMutableArray alloc]init];
    for (int i = 0; i<btnTitle.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(10+i*(btnX+btnW),5,btnW,btnH)];
        [btn setCorenerRadius:6 borderColor:White borderWidth:2.0];
        [btn setTitle:btnTitle[i] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:ClearColor width:btn.width height:btn.height title:btnTitle[i] ] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:BDThemeColor width:btn.width height:btn.height title:btnTitle[i] ] forState:UIControlStateSelected];
        if (i == 0) {
            [btn setSelected:YES];
        } else {
            [btn setSelected:NO];
        }
        
        
        btn.tag = i+100;
        
        
        [btn addTarget:self action:@selector(topViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.topTestView addSubview:btn];
        [viewBtnArr addObject:btn];
    }
    self.viewsBtnArr = [viewBtnArr copy];
    WeakSelf;
    self.topTestView.contentSize = CGSizeMake(btnTitle.count*(btnW+btnX)+15, 50);
    if (self.topTestView.contentSize.width<self.view.width*0.6) {
        [self.topTestView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(weakself.topTestView.contentSize.width);
        }];
        [self.topTestView layoutIfNeeded];
    }
    [self loadMainViewSubViews];
    
    
}

-(void)loadMainViewSubViews{
    _groupNum = 2;
    BD_TestDataParaVC *dataparaVC = [[BD_TestDataParaVC alloc]init];
    self.dataParaVC  = dataparaVC;
    for (int i = 0; i<2; i++) {
        BD_TestItemParamModel *model = [[BD_TestItemParamModel alloc]init];
        model.itemNum = i+1;
        model.itemName = @"递变";
        model.itemProject = @"Ia";
        [dataparaVC.testListDataSource addObject:model];
    }
    [dataparaVC reloadAllDatas];
    [self.mainView addSubview:dataparaVC.view];
    BD_VectorDiagramVC *vectorVC = [[BD_VectorDiagramVC alloc]init];
    
    NSMutableArray *headerTitles = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i<_groupNum; i++) {
        [headerTitles addObject:@[@"通道名称",@"幅值",@"单位",@"相位(°)",@"频率(Hz)"]];
    }
    vectorVC.baseHeaderTitles = [headerTitles copy];
    
    [self.mainView addSubview:vectorVC.view];
    self.vectorVC = vectorVC;
   
}

-(void)topViewBtnClick:(UIButton *)sender{
    NSLog(@"sendertag:%ld",sender.tag);
    [self scrollViewToCurrentViewWithIndex:sender.tag-100];
    [self.viewsBtnArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqual:sender]) {
            obj.selected = YES;
        } else {
            obj.selected = NO;
        }
    }];
}

-(void)scrollViewToCurrentViewWithIndex:(NSInteger)index{
    self.mainView.contentOffset = CGPointMake(self.mainView.width*index, 0);
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
