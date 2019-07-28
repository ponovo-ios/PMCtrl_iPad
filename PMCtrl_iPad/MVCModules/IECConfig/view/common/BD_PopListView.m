//
//  BD_PopListView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/6.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_PopListView.h"
#import "BD_PopListViewCell.h"
@interface BD_PopListView ()<UITableViewDataSource,UITableViewDelegate,UIPopoverPresentationControllerDelegate>

@end

@implementation BD_PopListView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}
-(instancetype)init{
    if (self = [super init]) {
        [self createTableView];
    }
    return self;
}
-(NSArray *)listdatasource{
    if (!_listdatasource) {
        _listdatasource = [[NSArray alloc]init];
    }
    return _listdatasource;
}
-(void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.left.and.right.mas_equalTo(self.view);
    }];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BD_PopListViewCell class]) bundle:nil] forCellReuseIdentifier:@"BD_PopListViewCellID"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listdatasource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    BD_PopListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BD_PopListViewCellID" forIndexPath:indexPath];
    UILabel *cellLabel = [cell viewWithTag:10];
    cellLabel.text = _listdatasource[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selecteTitleBlock(_listdatasource[indexPath.row]);
    [self  dismissViewControllerAnimated:YES completion:nil];
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
