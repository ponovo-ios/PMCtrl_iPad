//
//  BD_VectorDiagramVC.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/11.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_VectorDiagramVC.h"
#import "BD_VectorDiagramBaseView.h"
#import "UILabel+Extension.h"
#import "BD_TestDataParamModel.h"
#import "BD_VectorMaxValueModel.h"
@interface BD_VectorDiagramVC ()
//@property(nonatomic,strong)UIScrollView *scrollView;
//@property(nonatomic,strong)NSMutableArray<BD_VectorDiagramBaseView *> *vectorBaseViewArr;
@property(nonatomic,weak)BD_VectorDiagramBaseView *vectorBaseView;
@property(nonatomic,strong)UILabel *currentGroupL;
@property(nonatomic,assign)int currentGroup;
@property(nonatomic,strong)NSMutableArray<BD_VectorMaxValueModel *> *maxValueModels;
@end

@implementation BD_VectorDiagramVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentGroup = 0;
    [self loadSubViews];
    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillLayoutSubviews{
//    _vectorBaseViewArr[0].frame = CGRectMake(0, 0, self.scrollView.width, self.scrollView.height);
//    self.scrollView.contentSize = CGSizeMake(self.scrollView.width*self.vectorBaseViewArr.count, self.scrollView.height);
}
-(void)loadSubViews{
    WeakSelf;
    _currentGroupL = [UILabel labelWithText:@"第一组" textColor:White fontSize:18 alignment:NSTextAlignmentCenter sizeToFit:NO];
    _currentGroupL.text = [NSString stringWithFormat:@"第%d组/共%d组",_currentGroup,(int)_vectorDataSource.count];
    [self.view addSubview:_currentGroupL];
    [_currentGroupL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakself.view.mas_centerX);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *upOne = [[UIButton alloc]init];
    [upOne setTitle:@"上一组" forState:UIControlStateNormal];
    upOne.tag = 10;
    [upOne setTitleColor:White forState:UIControlStateNormal];
    [upOne setCorenerRadius:6 borderColor:BtnViewBorderColor borderWidth:1.0];
    [upOne addTarget:self action:@selector(changeGroupAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:upOne];
    [upOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakself.currentGroupL.mas_left).offset(-5);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *downOne = [[UIButton alloc]init];
    [downOne setTitle:@"下一组" forState:UIControlStateNormal];
    downOne.tag = 11;
    [downOne setTitleColor:White forState:UIControlStateNormal];
    [downOne addTarget:self action:@selector(changeGroupAction:) forControlEvents:UIControlEventTouchUpInside];
    [downOne setCorenerRadius:6 borderColor:BtnViewBorderColor borderWidth:1.0];
    [self.view addSubview:downOne];
    [downOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.currentGroupL.mas_right).offset(5);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
//    _scrollView = [[UIScrollView alloc]init];
//    _scrollView.showsHorizontalScrollIndicator = NO;
//    _scrollView.bounces = NO;
//    [self.view addSubview:_scrollView];
//    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(0);
//        make.right.mas_equalTo(0);
//        make.top.mas_equalTo(0);
//        make.bottom.mas_equalTo(downOne.mas_top).offset(-5);
//    }];
    BD_VectorDiagramBaseView *baseView = [[NSBundle mainBundle]loadNibNamed:@"BD_VectorDiagramBaseView" owner:nil options:nil].lastObject;
    if (self.vectorDataSource.count!=0 && self.baseHeaderTitles.count!=0) {
            baseView.formDataSource = self.vectorDataSource[0];
            baseView.headerViewTitles = self.baseHeaderTitles[0];
    }

    [baseView reloadTBView];
    [self.view addSubview:baseView];
    [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.right.mas_equalTo(0);
                make.top.mas_equalTo(0);
                make.bottom.mas_equalTo(downOne.mas_top).offset(-5);
    }];
    self.vectorBaseView = baseView;
    
    for (NSInteger i = 0; i<_baseHeaderTitles.count; i++) {
        [self.maxValueModels addObject:[[BD_VectorMaxValueModel alloc]init]];
    }
}

#pragma mark - 懒加载
//-(NSMutableArray *)vectorBaseViewArr{
//    if (!_vectorBaseViewArr) {
//        _vectorBaseViewArr = [[NSMutableArray alloc]init];
//    }
//    return _vectorBaseViewArr;
//}

-(NSMutableArray *)vectorDataSource{
    if (!_vectorDataSource) {
        _vectorDataSource = [[NSMutableArray alloc]init];
    }
    return _vectorDataSource;
}
-(NSArray<NSArray *> *)baseHeaderTitles{
    if (!_baseHeaderTitles) {
        _baseHeaderTitles = [[NSArray alloc] init];
    }
    return _baseHeaderTitles;
}
-(NSMutableArray<BD_VectorMaxValueModel *> *)maxValueModels{
    if (!_maxValueModels) {
        _maxValueModels = [[NSMutableArray alloc]init];
    }
    return _maxValueModels;
}
//添加矢量图分页
//-(void)loadVectorBaseView{
//    [self createVectorData];
//
//    _currentGroupL.text = [NSString stringWithFormat:@"第%d组/共%d组",_currentGroup,(int)_vectorDataSource.count];
//
//    for (int i = 0; i<self.baseHeaderTitles.count; i++) {
//        BD_VectorDiagramBaseView *baseView = [[NSBundle mainBundle]loadNibNamed:@"BD_VectorDiagramBaseView" owner:self options:nil].lastObject;
//        baseView.formDataSource = self.vectorDataSource[i];
//        baseView.headerViewTitles = self.baseHeaderTitles[i];
//        [baseView reloadTBView];
//
////        [self.scrollView addSubview:baseView];
////        [self.vectorBaseViewArr addObject:baseView];
//    }
//}





-(void)changeGroupAction:(UIButton *)sender{
    if (sender.tag == 10) {
        //上一组
        if (_currentGroup==0) {
            [MBProgressHUDUtil showMessage:@"已经是第一组" toView:self.view];
        } else {
            _currentGroup-=1;
        }
      
    } else {
        //下一组
        if (_currentGroup+1==_vectorDataSource.count) {
           [MBProgressHUDUtil showMessage:@"已经是最后一组" toView:self.view];
        } else {
            _currentGroup+=1;
        }
      
        
    }
    [self updateSubViews];
}

-(void)updateSubViews{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_currentGroup>=self.vectorDataSource.count) {
            _currentGroup = 0;
        }
        self.vectorBaseView.headerViewTitles = self.baseHeaderTitles[_currentGroup];
        self.vectorBaseView.formDataSource = self.vectorDataSource[_currentGroup];
        self.vectorBaseView.MAXAmplitudeModel = self.maxValueModels[_currentGroup];
        _currentGroupL.text = [NSString stringWithFormat:@"第%d组/共%d组",_currentGroup+1,(int)_vectorDataSource.count];
        [self.vectorBaseView reloadTBView];
    });
    
    
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
