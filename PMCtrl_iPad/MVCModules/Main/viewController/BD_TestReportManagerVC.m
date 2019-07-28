//
//  BD_TestReportManagerVC.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/23.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_TestReportManagerVC.h"
#import <QuickLook/QuickLook.h>
#import "BD_ReportListCell.h"
#import "BD_ReportInfoModel.h"
@interface BD_TestReportManagerVC ()<QLPreviewControllerDataSource,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *reportListTBView;
@property (nonatomic,strong)QLPreviewController *previewController;
@property (copy, nonatomic)NSURL *fileURL;
@end

@implementation BD_TestReportManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDataSource];
    [self loadSubViews];
    self.view.backgroundColor = MainBgColor;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadSubViews{

    self.reportListTBView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.reportListTBView.delegate = self;
    self.reportListTBView.dataSource = self;
    [self.reportListTBView setCorenerRadius:6 borderColor:BDThemeColor borderWidth:2.0];
    self.reportListTBView.backgroundColor = ClearColor;
    [self.view addSubview:self.reportListTBView];
    [self.reportListTBView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        
    }];
    [self.reportListTBView registerNib:[UINib nibWithNibName:NSStringFromClass([BD_ReportListCell class]) bundle:nil] forCellReuseIdentifier:@"BD_ReportListCellID"];
    
    
  

    self.previewController  =  [[QLPreviewController alloc]  init];
    self.previewController.dataSource  = self;
    self.fileURL = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"aa.pdf" ofType:nil]];
    
   
    self.previewController.modalPresentationStyle = UIModalPresentationCustom;
    //刷新界面,如果不刷新的话，不重新走一遍代理方法，返回的url还是上一次的url
    [self.previewController refreshCurrentPreviewItem];
    
   
}


-(NSArray<BD_ReportInfoModel *> *)reportListDatas{
    if (!_reportListDatas) {
        _reportListDatas = [[NSArray alloc]init];
    }
    return _reportListDatas;
}

#pragma mark - QLPreviewControllerDataSource
-(id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
    return self.fileURL;
}

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)previewController{
    return 1;
}
#pragma mark - UITableViewDataSource



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.reportListDatas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BD_ReportListCell *reportCell = [tableView dequeueReusableCellWithIdentifier:@"BD_ReportListCellID" forIndexPath:indexPath];
    reportCell.reportNum.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    reportCell.reportTime.text = _reportListDatas[indexPath.row].reportTime;
    reportCell.reportResult.text = _reportListDatas[indexPath.row].reportResult;
    return reportCell;
}
#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.fileURL = [NSURL URLWithString:_reportListDatas[indexPath.row].url];
    [self presentViewController:self.previewController animated:YES completion:nil];
    [self.previewController refreshCurrentPreviewItem];

}

-(void)loadDataSource{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i = 0; i<5; i++) {
        BD_ReportInfoModel * model = [[BD_ReportInfoModel alloc]init];
        model.reportNum = [NSString stringWithFormat:@"%d",i+1];
        model.url = [[NSBundle mainBundle]pathForResource:@"aa.pdf" ofType:nil];
        [arr addObject:model];
    }
    self.reportListDatas = [arr copy];
    [self.reportListTBView reloadData];
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
