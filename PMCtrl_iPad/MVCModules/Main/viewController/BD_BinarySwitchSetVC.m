//
//  BD_BinarySwitchSetVC.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/11.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_BinarySwitchSetVC.h"
#import "BD_QuickTestComParamSwitchSetCell.h"
#import "BD_TestBinarySwitchSetModel.h"
@interface BD_BinarySwitchSetVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *mainView;
@property(nonatomic,strong)BD_TestBinarySwitchSetModel *binaryDataLast;
@end

@implementation BD_BinarySwitchSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupView
{
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    UIButton *closeBtn = [[UIButton alloc]init];
    closeBtn.frame = CGRectMake(self.view.width-50,10, 35.0, 35.0);
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];

    
    _mainView = [[UIView alloc]initWithFrame:CGRectZero];
    _mainView.backgroundColor = BDThemeColor;
    _mainView.center = self.view.center;
    [self.view addSubview:_mainView];
    
    UIButton *okBtn = [[UIButton alloc]init];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn setCorenerRadius:8 borderColor:BtnViewBorderColor borderWidth:1.0];
    okBtn.tag = 101;
    [okBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_mainView addSubview:okBtn];
    
    [okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(-10);
    }];
    
    UIButton *cancelBtn = [[UIButton alloc]init];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setCorenerRadius:8 borderColor:BtnViewBorderColor borderWidth:1.0];
    cancelBtn.tag = 102;
    [cancelBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_mainView addSubview:cancelBtn];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.width.mas_equalTo(okBtn.mas_width);
        make.left.mas_equalTo(okBtn.mas_right).offset(10);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(-10);
    }];
    //view 抬头
    UILabel *title = [[UILabel alloc]init];
    title.text = @"开关量设置";
    title.textColor = White;
    title.font = [UIFont systemFontOfSize:20];
    title.textAlignment = NSTextAlignmentCenter;
    [_mainView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(5);
        make.height.mas_equalTo(30);
    }];
    //添加tableView视图
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [_mainView addSubview:_tableView];
    
    _tableView.backgroundColor = ClearColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BD_QuickTestComParamSwitchSetCell class]) bundle:nil] forCellReuseIdentifier:@"BD_QuickTestComParamSwitchSetCellID"];
    
    WeakSelf;
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.center.mas_equalTo(weakself.view.center);
        make.top.mas_equalTo(title.mas_bottom).offset(5);
        make.bottom.mas_equalTo(okBtn.mas_top).offset(-10);
    }];
    
}

#pragma mark - 懒加载
-(BD_TestBinarySwitchSetModel *)binaryData{
    if (!_binaryData) {
        _binaryData = [[BD_TestBinarySwitchSetModel alloc]init];
    }
    return _binaryData;
}
-(BD_TestBinarySwitchSetModel *)binaryDataLast{
    if (!_binaryDataLast) {
        _binaryDataLast = [[BD_TestBinarySwitchSetModel alloc]init];
    }
    return _binaryDataLast;
}
-(void)showBinaryView{
    WeakSelf;
    self.binaryDataLast = [self.binaryData copy];
    UIViewController *window = [[UIApplication sharedApplication]keyWindow].rootViewController;
    [window.view addSubview:self.view];
    [UIView animateWithDuration:0.3 animations:^{
        [weakself.tableView reloadData];
        weakself.mainView.frame = CGRectMake(0, 0, self.view.width*0.5,self.view.height*0.8);
        weakself.mainView.center = weakself.view.center;
        [weakself.mainView layoutIfNeeded];
    } completion:^(BOOL finished) {
        
        
    }];
}

-(void)closeBinaryView{
    WeakSelf;
    
    UIViewController *window = [[UIApplication sharedApplication]keyWindow].rootViewController;
    [window.view addSubview:self.view];
    [UIView animateWithDuration:0.3 animations:^{
        
        weakself.mainView.frame = CGRectZero;
        weakself.mainView.center = weakself.view.center;
        [weakself.mainView layoutIfNeeded];
    } completion:^(BOOL finished) {
        
        [self.view removeFromSuperview];
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 11;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeakSelf;
    BD_QuickTestComParamSwitchSetCell *switchCell = [tableView dequeueReusableCellWithIdentifier:@"BD_QuickTestComParamSwitchSetCellID" forIndexPath:indexPath];
    switchCell.makeInTitle.text = @[@"开入量A",@"开入量B",@"开入量C",@"开入量D",@"开入量E",@"开入量F",@"开入量G",@"开入量H",@"开入量I",@"开入量J",@"开入逻辑"][indexPath.row];
    switchCell.makeOutTitle.text = @[@"开出量1",@"开出量2",@"开出量3",@"开出量4",@"开出量5",@"开出量6",@"开出量7",@"开出量8",@"",@"",@"开出逻辑"][indexPath.row];
    switchCell.cellindex = indexPath;
    switchCell.backgroundColor = BDThemeColor;
    switchCell.contentView.backgroundColor = BDThemeColor;
    switch (indexPath.row) {
        case 0:
        {
            [switchCell.makeInSwitch setOn:(BOOL)self.binaryData.iKA];
            [switchCell.makeOutSwitch setOn:(BOOL)self.binaryData.iOut1];
        }
            break;
        case 1:
        {
            [switchCell.makeInSwitch setOn:(BOOL)self.binaryData.iKB];
            [switchCell.makeOutSwitch setOn:(BOOL)self.binaryData.iOut2];
        }
            break;
        case 2:
        {
            [switchCell.makeInSwitch setOn:(BOOL)self.binaryData.iKC];
            [switchCell.makeOutSwitch setOn:(BOOL)self.binaryData.iOut3];
        }
            break;
        case 3:
        {
            [switchCell.makeInSwitch setOn:(BOOL)self.binaryData.iKD];
            [switchCell.makeOutSwitch setOn:(BOOL)self.binaryData.iOut4];
        }
            break;
        case 4:
        {
            [switchCell.makeInSwitch setOn:(BOOL)self.binaryData.iKE];
            [switchCell.makeOutSwitch setOn:(BOOL)self.binaryData.iOut5];
        }
            break;
        case 5:
        {
            [switchCell.makeInSwitch setOn:(BOOL)self.binaryData.iKF];
            [switchCell.makeOutSwitch setOn:(BOOL)self.binaryData.iOut6];
        }
            break;
        case 6:
        {
            [switchCell.makeInSwitch setOn:(BOOL)self.binaryData.iKG];
            [switchCell.makeOutSwitch setOn:(BOOL)self.binaryData.iOut7];
        }
            break;
        case 7:
        {
            [switchCell.makeInSwitch setOn:(BOOL)self.binaryData.iKH];
            [switchCell.makeOutSwitch setOn:(BOOL)self.binaryData.iOut8];
        }
            break;
        case 8:
        {
            [switchCell.makeInSwitch setOn:(BOOL)self.binaryData.iKI];
            
        }
            break;
        case 9:
        {
            [switchCell.makeInSwitch setOn:(BOOL)self.binaryData.iKJ];
        }
            break;
        case 10:
        {
            [switchCell.makeInsegment setSelectedSegmentIndex:self.binaryData.iLogic];
            
        }
            break;
        
        default:
            break;
    }
    switchCell.binaryInChangedBlock = ^(NSNumber *switchState, NSIndexPath *cellIndex) {
        DLog(@"%@ -- %@", switchState, cellIndex);
//        [binaryInArr replaceObjectAtIndex:cellIndex.row withObject:switchState];
//        int kcl =
//        [binaryInArr[0] intValue] *pow(2 ,0) +
//        [binaryInArr[1] intValue] *pow(2, 1) +
//        [binaryInArr[2] intValue] *pow(2, 2) +
//        [binaryInArr[3] intValue] *pow(2, 3) +
//        [binaryInArr[4] intValue] *pow(2, 4) +
//        [binaryInArr[5] intValue] *pow(2, 5) +
//        [binaryInArr[6] intValue] *pow(2, 6) +
//        [binaryInArr[7] intValue] *pow(2, 7);
//        weakself.comParam.binaryIn = @(kcl);
//        if (self.binaryDelegate && [self.binaryDelegate respondsToSelector:@selector(changeBinaryState:)]) {
//            [self.binaryDelegate changeBinaryState:kcl];
//        }
        switch (cellIndex.row) {
            case 0:
            {
             weakself.binaryData.iKA = [switchState integerValue];
            }
                break;
            case 1:
            {
                weakself.binaryData.iKB = [switchState integerValue];
            }
                break;
            case 2:
            {
                weakself.binaryData.iKC = [switchState integerValue];
            }
                break;
            case 3:
            {
                weakself.binaryData.iKD = [switchState integerValue];
            }
                break;
            case 4:
            {
                weakself.binaryData.iKE = [switchState integerValue];
            }
                break;
            case 5:
            {
                weakself.binaryData.iKF = [switchState integerValue];
            }
                break;
            case 6:
            {
                weakself.binaryData.iKG = [switchState integerValue];
            }
                break;
            case 7:
            {
                weakself.binaryData.iKH = [switchState integerValue];
            }
                break;
            case 8:
            {
                weakself.binaryData.iKI = [switchState integerValue];
            }
                break;
            case 9:
            {
                weakself.binaryData.iKJ = [switchState integerValue];
            }
                break;
            default:
                break;
        }
      
    };
    
    switchCell.binaryOutChangedBlock = ^(NSNumber *state, NSIndexPath *index) {
        DLog(@"%@ -- %@", state, index);
//        [binaryOutArr replaceObjectAtIndex:index.row withObject:state];
//        int kcl_out =
//        [binaryOutArr[0] intValue] *pow(2 ,0) +
//        [binaryOutArr[1] intValue] *pow(2, 1) +
//        [binaryOutArr[2] intValue] *pow(2, 2) +
//        [binaryOutArr[3] intValue] *pow(2, 3) +
//        [binaryOutArr[4] intValue] *pow(2, 4) +
//        [binaryOutArr[5] intValue] *pow(2, 5) +
//        [binaryOutArr[6] intValue] *pow(2, 6) +
//        [binaryOutArr[7] intValue] *pow(2, 7);
//        weakself.comParam.binaryOut = @(kcl_out);
        switch (index.row) {
            case 0:
            {
                weakself.binaryData.iOut1 = [state integerValue];
            }
                break;
            case 1:
            {
                weakself.binaryData.iOut2 = [state integerValue];
            }
                break;
            case 2:
            {
                weakself.binaryData.iOut3 = [state integerValue];
            }
                break;
            case 3:
            {
                weakself.binaryData.iOut4 = [state integerValue];
            }
                break;
            case 4:
            {
                weakself.binaryData.iOut5 = [state integerValue];
            }
                break;
            case 5:
            {
                weakself.binaryData.iOut6 = [state integerValue];
            }
                break;
            case 6:
            {
                weakself.binaryData.iOut7 = [state integerValue];
            }
                break;
            case 7:
            {
                weakself.binaryData.iOut8 = [state integerValue];
            }
                break;
           
                break;
            default:
                break;
        }
//
    };
    
    switchCell.binaryLogicChangedBlock = ^(int segmentIndex) {
//        weakself.comParam.binaryLogic = segmentIndex;
        weakself.binaryData.iLogic = segmentIndex;
    };
    
    if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
        switchCell.makeInsegment.hidden = NO;
        
        switchCell.makeInSwitch.hidden = YES;
        switchCell.makeOutSwitch.hidden = YES;
    } else {
        switchCell.makeInsegment.hidden = YES;
        
        switchCell.makeInSwitch.hidden = NO;
        switchCell.makeOutSwitch.hidden = NO;
    }
    
    if (indexPath.row >= [tableView numberOfRowsInSection:indexPath.section]-3) {
        switchCell.makeOutTitle.hidden = YES;
        switchCell.lineView.hidden = YES;
        switchCell.makeOutSwitch.hidden = YES;
    } else {
        switchCell.makeOutTitle.hidden = NO;
        switchCell.lineView.hidden = NO;
        switchCell.makeOutSwitch.hidden = NO;
    }
    switchCell.lineView.hidden = YES;
    return switchCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(void)closeView:(UIButton *)sender{
    [self closeBinaryView];
}
-(void)buttonAction:(UIButton *)sender{
    
    if (sender.tag == 101) {
        //确定
        if (self.okActionBlock) {
            self.okActionBlock();
        }
        [self closeBinaryView];
    } else {
        //取消
        self.binaryData.iKA = self.binaryDataLast.iKA;
        self.binaryData.iKB = self.binaryDataLast.iKB;
        self.binaryData.iKC = self.binaryDataLast.iKC;
        self.binaryData.iKD = self.binaryDataLast.iKD;
        self.binaryData.iKE = self.binaryDataLast.iKE;
        self.binaryData.iKF = self.binaryDataLast.iKF;
        self.binaryData.iKG = self.binaryDataLast.iKG;
        self.binaryData.iKH = self.binaryDataLast.iKH;
        self.binaryData.iKI = self.binaryDataLast.iKI;
        self.binaryData.iKJ = self.binaryDataLast.iKJ;
        self.binaryData.iLogic = self.binaryDataLast.iLogic;
        self.binaryData.iOut1 = self.binaryDataLast.iOut1;
        self.binaryData.iOut2 = self.binaryDataLast.iOut2;
        self.binaryData.iOut3 = self.binaryDataLast.iOut3;
        self.binaryData.iOut4 = self.binaryDataLast.iOut4;
        self.binaryData.iOut5 = self.binaryDataLast.iOut5;
        self.binaryData.iOut6 = self.binaryDataLast.iOut6;
        self.binaryData.iOut7 = self.binaryDataLast.iOut7;
        self.binaryData.iOut8 = self.binaryDataLast.iOut8;
        [self closeBinaryView];
    }
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
