//
//  BD_OutputwaveShapeTBView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/28.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_OutputwaveShapeTBView.h"
#import "BD_OutputwaveShapeCell.h"
#import "BD_TestDataParamModel.h"
@interface BD_OutputwaveShapeTBView()<UITableViewDelegate,UITableViewDataSource>
//@property(nonatomic,strong)NSMutableArray *voltageSelectedArr;
//@property(nonatomic,strong)NSMutableArray *currentSelectedArr;
@end
@implementation BD_OutputwaveShapeTBView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.dataSource = self;
        self.delegate = self;
        self.tableFooterView  = [UIView new];
        self.bounces = NO;
        self.estimatedRowHeight = 0;
        [self registerNib:[UINib nibWithNibName:@"BD_OutputwaveShapeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BD_OutputwaveShapeCellID"];
        [self createTimer];
        [self stopTimer];//开始不启动定时器，试验开始后，启动定时器
       
        
    }
    return self;
}

-(NSInteger)numberOfSections{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.frame.size.height/2;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    BD_OutputwaveShapeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BD_OutputwaveShapeCellID" forIndexPath:indexPath];
    cell.isShowLinewave = _hasShowWaveImage;
    cell.waveDataModel = self.dataArr[indexPath.row];
    if (self.selecteddataArr.count!=0) {
        if (self.dataArr[0].voltageArr.count == 4 && self.selecteddataArr[0].voltageArr.count==3) {
            [self.selecteddataArr[0].voltageArr addObject:@(YES)];
        }
        if (self.dataArr[0].voltageArr.count == 3 && self.selecteddataArr[0].voltageArr.count==4) {
            [self.selecteddataArr[0].voltageArr removeLastObject];
        }
        
        cell.voltageSelectedArr = self.selecteddataArr[indexPath.row].voltageArr;
        cell.currentSelectedArr = self.selecteddataArr[indexPath.row].currentArr;
    }
   
  
    WeakSelf;
    cell.selectedWaveShapeViewBlock = ^(NSMutableArray *voltageSelectedArr, NSMutableArray *currentSelectedArr) {
        weakself.selecteddataArr[indexPath.row].voltageArr = voltageSelectedArr;
        weakself.selecteddataArr[indexPath.row].currentArr = currentSelectedArr;
    };
    [cell.tableView reloadData];//必须刷新cell的tableView,否则，不能正确的显示
    
    return cell;
}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    DLog(@"tableView contentofset:%f",self.contentOffset.y)
//    
//}
#pragma mark - 懒加载
-(NSArray <BD_OutputwaveShapeDataModel *> *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSArray alloc]init];
    }
    return _dataArr;
}

-(NSMutableArray <BD_OutputwaveShapeDataModel *> *)selecteddataArr{
    if (!_selecteddataArr) {
        _selecteddataArr = [[NSMutableArray alloc]init];
    }
    return _selecteddataArr;
}
//-(NSMutableArray *)voltageSelectedArr{
//    if (!_voltageSelectedArr) {
//
//        _voltageSelectedArr = [[NSMutableArray alloc]initWithArray:@[@(YES),@(YES),@(YES)]];
//
//    }
//    return _voltageSelectedArr;
//}
//-(NSMutableArray *)currentSelectedArr{
//    if (!_currentSelectedArr) {
//        _currentSelectedArr = [[NSMutableArray alloc]initWithArray:@[@(YES),@(YES),@(YES)]];
//    }
//    return _currentSelectedArr;
//}

-(void)startTimer{
    [_waveTimer setFireDate:[NSDate distantPast]];
}

-(void)stopTimer{
    [_waveTimer setFireDate:[NSDate distantFuture]];
}
-(void)createTimer{
    _waveTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(refreshWaveData) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_waveTimer forMode:NSRunLoopCommonModes];
}
-(void)cancelTimer{
    [_waveTimer invalidate];
    _waveTimer = nil;
}


-(void)refreshWaveData{
    
    if (_wavedelegate && [self.wavedelegate respondsToSelector:@selector(refreshOutputwaveData)]) {
        [self.wavedelegate refreshOutputwaveData];
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
