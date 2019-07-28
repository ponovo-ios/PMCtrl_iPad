//
//  BD_QuickTestVectorgraphTBView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/17.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_QuickTestVectorgraphTBView.h"
#import "BD_QuickTestVactorgraphCell.h"
#import "BD_QuickTestVactorgraphModel.h"
#import "BD_TestDataParamModel.h"
@interface BD_QuickTestVectorgraphTBView()<UITableViewDelegate,UITableViewDataSource>{
   
}

@end



@implementation BD_QuickTestVectorgraphTBView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = ClearColor;
        self.bounces  = NO;
        self.tableFooterView = [UIView new];
        [self registerNib:[UINib nibWithNibName:@"BD_QuickTestVactorgraphCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BD_QuickTestVactorgraphCellID"];
      

    }
    return  self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self endEditing:YES];
}

-(void)endEditing{
    [self endEditing:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.frame.size.height/2;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _drawViewDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BD_QuickTestVactorgraphCell *cell = [self dequeueReusableCellWithIdentifier:@"BD_QuickTestVactorgraphCellID" forIndexPath:indexPath];
    cell.titleArr = [NSArray arrayWithArray:[self changeTotitleArr]][indexPath.row];
    cell.vactorgraphData = _drawViewDataSource[indexPath.row];
    cell.cellIndex = indexPath.row;
    if (self.selectedDataArr && self.selectedDataArr.count!=0) {
        cell.voltageSelectedArr = self.selectedDataArr[indexPath.row][0];
        cell.currentSelectedArr = self.selectedDataArr[indexPath.row][1];
    }
    WeakSelf;
    cell.selectedArrBlock = ^(NSInteger index, NSArray *volSelectedArr, NSArray *curSelectedArr) {
        weakself.selectedDataArr[index][0] = [volSelectedArr mutableCopy];
       weakself.selectedDataArr[index][1] = [curSelectedArr mutableCopy];
    };
    [cell setCellData];
    return cell;
}

#pragma mark - 懒加载

-(NSMutableArray<BD_QuickTestVactorgraphModel *> *)drawViewDataSource{
    if (!_drawViewDataSource) {
        _drawViewDataSource = [[NSMutableArray alloc]init];
    }
    return _drawViewDataSource;
}
-(NSMutableArray *)selectedDataArr{
    if (!_selectedDataArr) {
        _selectedDataArr = [[NSMutableArray alloc]init];
    }
    return _selectedDataArr;
}
//根据矢量图数据源配置titleArr
-(NSMutableArray *)changeTotitleArr{
    NSMutableArray *resultArr = [[NSMutableArray alloc]init];//返回最终的结果
    for (int i = 0; i<_drawViewDataSource.count; i++) {
         NSMutableArray *titleArr = [[NSMutableArray alloc]init];
        for (int n = 0;n<_drawViewDataSource[i].voltageArr.count;n++) {
            [titleArr addObject:_drawViewDataSource[i].voltageArr[n].titleName];
        }
        for (int j = 0;j<_drawViewDataSource[i].currentArr.count;j++) {
            [titleArr addObject:_drawViewDataSource[i].currentArr[j].titleName];
        }
        [resultArr addObject:titleArr];
    }
    return  resultArr;
}

#pragma mark-创建选择状态数组

-(void)createCellSelectedArr{
    [self.selectedDataArr removeAllObjects];
    
        for (int i = 0; i<_drawViewDataSource.count; i++) {
        NSMutableArray *volcellArr = [[NSMutableArray alloc]init];
        NSMutableArray *curcellArr = [[NSMutableArray alloc]init];
        for (int n = 0;n<_drawViewDataSource[i].voltageArr.count;n++) {
            [volcellArr addObject:@(YES)];
        }
        for (int j = 0;j<_drawViewDataSource[i].currentArr.count;j++) {
            [curcellArr addObject:@(YES)];
        }
        
            [self.selectedDataArr addObject:[@[volcellArr,curcellArr] mutableCopy]];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
