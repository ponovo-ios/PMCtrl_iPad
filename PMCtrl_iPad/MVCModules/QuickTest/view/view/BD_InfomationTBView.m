//
//  BD_InfomationTBView.m
//  PMCtrl_iPad
//
//  Created by 张姝枫 on 2018/1/30.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_InfomationTBView.h"
#import "BD_InformationHeaderView.h"
#import "BD_InformationFormCell.h"

@interface BD_InfomationTBView()<UITableViewDelegate,UITableViewDataSource>{

}
@property(nonatomic,strong)NSArray *headerTitles;
@end
@implementation BD_InfomationTBView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style headerTitles:(NSArray *)headerTitles{
    if (self = [super initWithFrame:frame style:style]) {
        _headerTitles = headerTitles;
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = ClearColor;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableFooterView = [UIView new];
        self.scrollEnabled = YES;
        self.bounces = NO;
        _isScrollTBView = NO;
    }
    return  self;
}

- (void)layoutSubviews {
    if (!_isScrollTBView) {
        [self resetContentOffsetIfNeeded];
        [super layoutSubviews];
    } else {
        [super layoutSubviews];
    }
    
}

#pragma mark - 懒加载
-(NSMutableArray<BD_TestInformationModel *> *)infoDataSource{
    if (!_infoDataSource) {
        _infoDataSource = [[NSMutableArray alloc]init];
        
    }
    return _infoDataSource;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.infoDataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    BD_InformationHeaderView *headerView = [[BD_InformationHeaderView alloc]initWithTitles:_headerTitles];
    [headerView setFrame: CGRectMake(0, 0,self.width, 50)];
    [headerView loadViews];
    headerView.backgroundColor = FormBgColor;
    return headerView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BD_InformationFormCell * cell = [[BD_InformationFormCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BD_InformationFormCellID" itemCount:_headerTitles.count];
    [cell setFrame: CGRectMake(0, 0,self.width, 60)];
    if (cell.cellLabelArr.count == 0) {
        [cell loadViews];
    }
    [cell setLabelDataWithDataModel:self.infoDataSource[indexPath.row]];
    return cell;
}

-(void)createFalsedata{
//    for (int i = 0; i<5; i++) {
//      BD_TestInformationModel *model = [[BD_TestInformationModel alloc]init];
//        model.infoindex = i+1;
//        model.currentTime = @"2018-90-09";
//        model.actionType = BDActionType_Start;
//        model.binaryIn = @"0000111010";
//        model.actionTime = @"dfd";
//        [self.infoDataSource addObject:model];
//    }
  
    
}



-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _isScrollTBView = YES;
}

- (void)resetContentOffsetIfNeeded {
    CGPoint contentOffset  = self.contentOffset;
    
     if (contentOffset.y <= (self.contentSize.height - self.bounds.size.height)) {
        contentOffset.y = self.contentSize.height - self.bounds.size.height;
    }
    
    [self setContentOffset: contentOffset];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
