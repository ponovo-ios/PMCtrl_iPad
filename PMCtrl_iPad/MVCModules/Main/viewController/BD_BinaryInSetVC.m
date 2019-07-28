//
//  BD_BinaryInSetVC.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/12.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_BinaryInSetVC.h"
#import "BD_BinarySettingCell.h"
#import "BD_BinaryInSettingModel.h"
#import "UILabel+Extension.h"
#import "BD_PopListViewManager.h"
@interface BD_BinaryInSetVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,weak)UIView *mainView;
@property(nonatomic,strong)NSString *binaryModelType;
@property(nonatomic,weak)UILabel *binaryModelTypeLabel;
@property(nonatomic,strong)BD_BinaryInSetData *lastBinaryData;
@end

@implementation BD_BinaryInSetVC

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
 
    _binaryModelType = @"开入量模式";
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    UIButton *closeBtn = [[UIButton alloc]init];
    closeBtn.frame = CGRectMake(self.view.width-50,10, 35.0, 35.0);
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    
    
   UIView *mainView = [[UIView alloc]initWithFrame:CGRectZero];
    mainView.backgroundColor = BDThemeColor;
    mainView.center = self.view.center;
    _mainView = mainView;
    [self.view addSubview:mainView];
    
   
    
    UIButton *getBtn = [[UIButton alloc]init];
    [getBtn setTitle:@"获取" forState:UIControlStateNormal];
    [getBtn setCorenerRadius:8 borderColor:BtnViewBorderColor borderWidth:1.0];
    getBtn.tag = 102;
    [getBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_mainView addSubview:getBtn];
    
    [getBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(-10);
    }];
    
    UIButton *okBtn = [[UIButton alloc]init];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn setCorenerRadius:8 borderColor:BtnViewBorderColor borderWidth:1.0];
    okBtn.tag = 101;
    [okBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_mainView addSubview:okBtn];
    
    [okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(getBtn.mas_width);
        make.left.mas_equalTo(getBtn.mas_right).offset(10);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(-10);
    }];
    
    UIButton *cancelBtn = [[UIButton alloc]init];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setCorenerRadius:8 borderColor:BtnViewBorderColor borderWidth:1.0];
    cancelBtn.tag = 103;
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
    title.text = @"开入量设置";
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
    
    
    //添加开入模式
    
    UILabel *binarytitle = [UILabel labelWithText:@"开入模式:" textColor:White fontSize:18 alignment:NSTextAlignmentLeft sizeToFit:NO];
    [_mainView addSubview:binarytitle];
    [binarytitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(100);
        make.top.mas_equalTo(title.mas_bottom).offset(5);
        make.height.mas_equalTo(35);
    }];
   UILabel *binaryModelTypeLabel = [UILabel labelWithText:_binaryModelType textColor:White fontSize:15 alignment:NSTextAlignmentLeft sizeToFit:NO];
    [binaryModelTypeLabel setCorenerRadius:6 borderColor:White borderWidth:2.0];
    [_mainView addSubview:binaryModelTypeLabel];
    [binaryModelTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(binarytitle.mas_right).offset(5);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(title.mas_bottom).offset(5);
        make.height.mas_equalTo(35);
    }];
    _binaryModelTypeLabel = binaryModelTypeLabel;
    
    
    //添加tableView视图
   UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [_mainView addSubview:tableView];
    tableView.backgroundColor = ClearColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BD_BinarySettingCell class]) bundle:nil] forCellReuseIdentifier:@"BD_BinarySettingCellID"];
    
    __weak typeof(self) weakself = self;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.center.mas_equalTo(weakself.view.center); make.top.mas_equalTo(weakself.binaryModelTypeLabel.mas_bottom).offset(10);
        make.bottom.mas_equalTo(okBtn.mas_top).offset(-10);
    }];
    _tableView = tableView;
    
    
}

-(void)showBinaryInView{
    WeakSelf;
    self.lastBinaryData.binaryStyle = self.binarydata.binaryStyle;
    [self.lastBinaryData.binaryInfoList removeAllObjects];
    [self.binarydata.binaryInfoList enumerateObjectsUsingBlock:^(BD_BinaryInSettingModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [weakself.lastBinaryData.binaryInfoList addObject:[obj copy]];
    }];
    
    UIViewController *window = [[UIApplication sharedApplication]keyWindow].rootViewController;
    [window.view addSubview:self.view];
    [UIView animateWithDuration:0.3 animations:^{
        
        weakself.mainView.frame = CGRectMake(0, 0, self.view.width*0.5,self.view.height*0.8);
        weakself.mainView.center = weakself.view.center;
        [weakself.mainView layoutIfNeeded];
    } completion:^(BOOL finished) {
        
        
    }];
}

-(void)closeBinaryInView{
    WeakSelf;
    self.binarydata.binaryStyle = self.lastBinaryData.binaryStyle;
    [self.binarydata.binaryInfoList enumerateObjectsUsingBlock:^(BD_BinaryInSettingModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.title = weakself.lastBinaryData.binaryInfoList[idx].title;
        obj.isBlankNode = weakself.lastBinaryData.binaryInfoList[idx].isBlankNode;
        obj.rolloverValue = weakself.lastBinaryData.binaryInfoList[idx].rolloverValue;
    }];
    
    UIViewController *window = [[UIApplication sharedApplication]keyWindow].rootViewController;
    [window.view addSubview:self.view];
    [UIView animateWithDuration:0.3 animations:^{
        
        weakself.mainView.frame = CGRectZero;
        weakself.mainView.center = weakself.view.center;
        [weakself.mainView layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.tableView reloadData];
        [self.view removeFromSuperview];
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.binarydata.binaryInfoList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BD_BinarySettingCell *binarycell = [tableView dequeueReusableCellWithIdentifier:@"BD_BinarySettingCellID" forIndexPath:indexPath];
    binarycell.backgroundColor = ClearColor;
    binarycell.contentView.backgroundColor = ClearColor;
    [binarycell.contentView viewWithTagToLabel:13].text = self.binarydata.binaryInfoList[indexPath.row].title;
    [[binarycell.contentView viewWithTagToBtn:14] setSelected:self.binarydata.binaryInfoList[indexPath.row].isBlankNode];
    
    [binarycell.contentView viewWithTagToTF:15].text = self.binarydata.binaryInfoList[indexPath.row].rolloverValue;
    
    binarycell.cellIndex = (int)indexPath.row;
    if (indexPath.row == 10) {
        [binarycell.contentView viewWithTagToBtn:14].hidden = YES;
        [binarycell.contentView viewWithTagToLabel:16].text = @"ms";
    } else {
        [binarycell.contentView viewWithTagToBtn:14].hidden = NO;
        [binarycell.contentView viewWithTagToLabel:16].text = @"V";
    }
    if (indexPath.row!=10) {
        if ([binarycell.contentView viewWithTagToBtn:14].selected) {
            [[BD_Utils shared]setViewState:NO view:[binarycell.contentView viewWithTagToTF:15]];
        } else {
            [[BD_Utils shared]setViewState:YES view:[binarycell.contentView viewWithTagToTF:15]];
        }
    } else {
        [[BD_Utils shared]setViewState:YES view:[binarycell.contentView viewWithTagToTF:15]];
    }
   
    WeakSelf;
    binarycell.selectedBlankNodeBlock = ^(int cellIndex, bool selectedState) {
        DLog(@"选择行:%d 状态:%d",cellIndex,selectedState);
        weakself.binarydata.binaryInfoList[cellIndex].isBlankNode = selectedState;
    };
    binarycell.rolloverValueBlock = ^(int cellIndex, NSString *rolloverValue) {
        weakself.binarydata.binaryInfoList[cellIndex].rolloverValue = rolloverValue;
    };
    return  binarycell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = BDThemeColor;
    headerView.frame = CGRectMake(0,0, self.tableView.frame.size.width, 40);

    UILabel *binaryL  = [[UILabel alloc]init];
    [headerView addSubview:binaryL];
    [binaryL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
    }];
    binaryL.textColor = White;
    binaryL.text = @"开入量";

    UILabel *thresholdL  = [[UILabel alloc]init];
    [headerView addSubview:thresholdL];
    [thresholdL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-90.0);
        make.centerY.mas_equalTo(binaryL);
    }];
    thresholdL.textColor = White;
    thresholdL.text = @"翻转门槛";
    UILabel *blankNodeL  = [[UILabel alloc]init];
    [headerView addSubview:blankNodeL];
    [blankNodeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(binaryL.mas_right).mas_offset(115);
        make.centerY.mas_equalTo(binaryL);
    }];
    blankNodeL.textColor = White;
    blankNodeL.text = @"空节点";
    
    return headerView;
}


-(void)closeView:(UIButton *)sender{
    self.binarydata.binaryStyle = self.lastBinaryData.binaryStyle;
    WeakSelf;
    [self.binarydata.binaryInfoList enumerateObjectsUsingBlock:^(BD_BinaryInSettingModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.title = weakself.lastBinaryData.binaryInfoList[idx].title;
        obj.isBlankNode = weakself.lastBinaryData.binaryInfoList[idx].isBlankNode;
        obj.rolloverValue = weakself.lastBinaryData.binaryInfoList[idx].rolloverValue;
    }];
    
    
    [self closeBinaryInView];
}

-(void)buttonAction:(UIButton *)sender{
    
    if (sender.tag == 101) {
        //确定
         WeakSelf;
        self.lastBinaryData.binaryStyle = self.binarydata.binaryStyle;
        [self.lastBinaryData.binaryInfoList enumerateObjectsUsingBlock:^(BD_BinaryInSettingModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.title = weakself.binarydata.binaryInfoList[idx].title;
            obj.isBlankNode = weakself.binarydata.binaryInfoList[idx].isBlankNode;
            obj.rolloverValue = weakself.binarydata.binaryInfoList[idx].rolloverValue;
        }];
        
        BD_BinaryInSetData *binarydata = [[BD_BinaryInSetData alloc]init];
        binarydata.binaryStyle = [_binaryModelType isEqualToString:@"开入量模式"]?0:1;
        binarydata.binaryInfoList = self.binarydata.binaryInfoList;
        binarydata.bitime = [[self.binarydata.binaryInfoList lastObject].rolloverValue intValue];
      bool isSuccess =  [[OCCenter shareCenter]binarySetAction:binarydata];
        if (isSuccess) {
            [self closeBinaryInView];
        } else {
            [BD_PopListViewManager showAlertView:self title:@"" message:@"连接网络失败，请检查网络" okAction:^{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
            }];
        }
    } else if(sender.tag == 102) {
        //获取
        WeakSelf;
        BD_BinaryInSetData *binaryData = [[OCCenter shareCenter]getBinaryInfo];
        if (binaryData) {
            [binaryData.binaryInfoList enumerateObjectsUsingBlock:^(BD_BinaryInSettingModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                weakself.binarydata.binaryInfoList[idx].isBlankNode = obj.isBlankNode;
                weakself.binarydata.binaryInfoList[idx].rolloverValue = obj.rolloverValue;
            }];
            self.binarydata.binaryInfoList.lastObject.rolloverValue = [NSString stringWithFormat:@"%d",binaryData.bitime];
            if (binaryData.binaryStyle==0) {
                _binaryModelType = @"开入量模式";
            } else {
                _binaryModelType = @"采集模式";
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
               _binaryModelTypeLabel.text = _binaryModelType;
                [self.tableView reloadData];
            });
            
        } else {
            [BD_PopListViewManager showAlertView:self title:@"" message:@"连接网络失败，请检查网络" okAction:^{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
            }];
        }
        
    } else {
        [self closeBinaryInView];
    }
}

-(BD_BinaryInSetData *)binarydata{
    if (!_binarydata) {
        _binarydata = [[BD_BinaryInSetData alloc]init];
        _binarydata.binaryStyle = [_binaryModelType isEqualToString:@"开入量模式"]?0:1;
        NSMutableArray *binaryParaArr = [[NSMutableArray alloc]init];
  
        NSArray *titles =  @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I  ",@"J ",@"开入防抖时间"];
        for (NSInteger i=0; i<titles.count ; i++) {
            BD_BinaryInSettingModel *model = [[BD_BinaryInSettingModel alloc]init];
            model.title = titles[i];
            if (i == titles.count-1) {
                model.rolloverValue = @"2";
            }
            [binaryParaArr addObject:model];
        }
        _binarydata.binaryInfoList = binaryParaArr;
        _binarydata.bitime = [[self.binarydata.binaryInfoList lastObject].rolloverValue intValue];
    }
   return _binarydata;
}

-(BD_BinaryInSetData *)lastBinaryData{
    if (!_lastBinaryData) {
        _lastBinaryData = [[BD_BinaryInSetData alloc]init];
    }
    return _lastBinaryData;
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
