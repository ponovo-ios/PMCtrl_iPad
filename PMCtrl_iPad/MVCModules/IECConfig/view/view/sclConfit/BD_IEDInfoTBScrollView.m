//
//  BD_IEDInfoTBScrollView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/8.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_IEDInfoTBScrollView.h"
#import "BD_SCLConfigHeaderView.h"
#import "BD_SCLConfigCell.h"
#import "BD_IEDInfoModel.h"
@interface BD_IEDInfoTBScrollView()<UITableViewDelegate,UITableViewDataSource>
@end

@implementation BD_IEDInfoTBScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(instancetype)initWithData:(NSArray *)datainfo{
    if (self = [super init]) {
       
        _viewtype = BD_IEDInfoType_GOSend;
        _iedInfoArr = datainfo;
        _headerTitles = [[NSArray alloc]init];
        [self loadViews];
    }
    return self;
}

-(void)loadViews{
    _scrollView = [[UIScrollView alloc]init];
  
    _scrollView.contentSize = CGSizeMake(_headerTitles.count*150, self.height);
    [self addSubview:_scrollView];
    _tbView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
 
    _tbView.backgroundColor = ClearColor;
    _tbView.dataSource = self;
    _tbView.delegate = self;
    _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
   
    [_scrollView addSubview:_tbView];
}
-(void)selectedFirstItem{
    if (_iedInfoArr.count!=0) {
        [_tbView  selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
}
-(void)layoutSubviews{
    _scrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _scrollView.contentSize = CGSizeMake(_headerTitles.count*(150+10), self.height);
    _tbView.frame = CGRectMake(0,0,_scrollView.contentSize.width,_scrollView.contentSize.height);
}
-(void)reloadTBData{
    [_tbView reloadData];
}

#pragma mark - tableView dataSource delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _iedInfoArr.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BD_SCLConfigHeaderView *headerView = [[BD_SCLConfigHeaderView alloc]initWithData:_headerTitles viewWidth:150];
    return headerView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    //    if (_) {
    //        BD_SCLConfigCell *goSendCell;
    //        if (!goSendCell) {
    //            BD_GSEInfo *gseinfo = _infoModel.GSEList[indexPath.row];
    //            goSendCell = [[BD_SCLConfigCell alloc]initWithData:@[[NSString stringWithFormat:@"%ld",indexPath.row+1],gseinfo.APPID,gseinfo.MAC_Adress,[NSString stringWithFormat:@"%ld",gseinfo.recNum],gseinfo.DataSetDesc,gseinfo.datSet,gseinfo.appID,gseinfo.ldInst,gseinfo.VLAN_ID,gseinfo.VLAN_PRIORITY,gseinfo.confRev,] reuseIdentifier:@"gooseSendCell"];
    //        } else {
    //            goSendCell = [tableView dequeueReusableCellWithIdentifier:@"gooseSendCell" forIndexPath:indexPath];
    //        }
    //        cell = goSendCell;
    //    } else if ([tableView isEqual:_gooseSubTBView.tbView]) {
    //        BD_SCLConfigCell *goSendCell;
    //        if (!goSendCell) {
    //            BD_GSEInfo *gseinfo = _infoModel.GSEList[indexPath.row];
    //            goSendCell = [[BD_SCLConfigCell alloc]initWithData:@[[NSString stringWithFormat:@"%ld",indexPath.row+1],gseinfo.APPID,gseinfo.MAC_Adress,gseinfo.apName,[NSString stringWithFormat:@"%ld",gseinfo.recNum],gseinfo.DataSetDesc,gseinfo.datSet,gseinfo.appID,gseinfo.ldInst,gseinfo.VLAN_ID,gseinfo.VLAN_PRIORITY,gseinfo.confRev] reuseIdentifier:@"gooseSendCell"];
    //        } else {
    //            goSendCell = [tableView dequeueReusableCellWithIdentifier:@"gooseSendCell" forIndexPath:indexPath];
    //        }
    //        cell = goSendCell;
    //    } else  if ([tableView isEqual:_smvSendTBView.tbView]) {
    //        BD_SCLConfigCell *svSendCell;
    //        if (!svSendCell) {
    //            BD_SMVInfo *svinfo = _infoModel.SMVList[indexPath.row];
    //            svSendCell = [[BD_SCLConfigCell alloc]initWithData:@[[NSString stringWithFormat:@"%ld",indexPath.row+1],svinfo.APPID,svinfo.MAC_Adress,svinfo.apName,[NSString stringWithFormat:@"%ld",svinfo.recNum],svinfo.DataSetDesc,svinfo.datSet,svinfo.SmvID,svinfo.VLAN_ID,svinfo.VLAN_PRIORITY,svinfo.confRev,[NSString stringWithFormat:@"%ld",svinfo.nofASDU],[NSString stringWithFormat:@"%ld",svinfo.smpRate]] reuseIdentifier:@"svSendCell"];
    //        }else {
    //            svSendCell = [tableView dequeueReusableCellWithIdentifier:@"svSendCell" forIndexPath:indexPath];
    //        }
    //        cell = svSendCell;
    //    }  else if ([tableView isEqual:_smvSubTBView.tbView]) {
    //        BD_SCLConfigCell *goSendCell;
    //        if (!goSendCell) {
    //            BD_GSEInfo *gseinfo = _infoModel.GSEList[indexPath.row];
    //            goSendCell = [[BD_SCLConfigCell alloc]initWithData:@[[NSString stringWithFormat:@"%ld",indexPath.row+1],gseinfo.APPID,gseinfo.MAC_Adress,[NSString stringWithFormat:@"%ld",gseinfo.recNum],gseinfo.DataSetDesc,gseinfo.datSet,gseinfo.appID,gseinfo.ldInst,gseinfo.VLAN_ID,gseinfo.VLAN_PRIORITY,gseinfo.confRev,] reuseIdentifier:@"gooseSendCell"];
    //        }else {
    //            goSendCell = [tableView dequeueReusableCellWithIdentifier:@"svSendCell" forIndexPath:indexPath];
    //        }
    //        cell = goSendCell;
    //    }
    
    
    WeakSelf;
    if (_viewtype == BD_IEDInfoType_GOSend) {
        BD_SCLConfigCell *goSendCell;
        if (!goSendCell) {
            BD_GSEInfo *gseinfo = _iedInfoArr[indexPath.row];
            goSendCell = [[BD_SCLConfigCell alloc]initWithData:@[[NSString stringWithFormat:@"%ld",indexPath.row+1],gseinfo.APPID,gseinfo.MAC_Adress,gseinfo.apName,[NSString stringWithFormat:@"%ld",gseinfo.recNum],gseinfo.DataSetDesc,gseinfo.datSet,gseinfo.appID,gseinfo.ldInst,gseinfo.VLAN_ID,gseinfo.VLAN_PRIORITY,gseinfo.confRev,] viewWidth:150 reuseIdentifier:@"gooseSendCell"];
        } else {
            goSendCell = [tableView dequeueReusableCellWithIdentifier:@"gooseSendCell" forIndexPath:indexPath];
        }
        goSendCell.cellIndex = indexPath.row;
        
        goSendCell.checkIEDItemBlock = ^(NSInteger iedIndex, BOOL state) {
           weakself.checkedBlock(iedIndex, weakself.viewtype,state);
        };
        cell = goSendCell;
    } else if (_viewtype == BD_IEDInfoType_SMVSend) {
        BD_SCLConfigCell *svSendCell;
        if (!svSendCell) {
            BD_SMVInfo *svinfo = _iedInfoArr[indexPath.row];
            svSendCell = [[BD_SCLConfigCell alloc]initWithData:@[[NSString stringWithFormat:@"%ld",indexPath.row+1],svinfo.APPID,svinfo.MAC_Adress,svinfo.apName,[NSString stringWithFormat:@"%ld",svinfo.recNum],svinfo.DataSetDesc,svinfo.datSet,svinfo.SmvID,svinfo.VLAN_ID,svinfo.VLAN_PRIORITY,svinfo.confRev,[NSString stringWithFormat:@"%ld",svinfo.nofASDU],[NSString stringWithFormat:@"%ld",svinfo.smpRate]] viewWidth:150 reuseIdentifier:@"svSendCell"];
        }else {
            svSendCell = [tableView dequeueReusableCellWithIdentifier:@"svSendCell" forIndexPath:indexPath];
        }
        svSendCell.cellIndex = indexPath.row;
        svSendCell.checkIEDItemBlock = ^(NSInteger iedIndex,BOOL state) {
            weakself.checkedBlock(iedIndex, weakself.viewtype,state);
        };
        
        cell = svSendCell;
    } else if(_viewtype == BD_IEDInfoType_GOSub){
        cell = [[UITableViewCell alloc]init];
    }else if(_viewtype == BD_IEDInfoType_SMVSub){
        cell = [[UITableViewCell alloc]init];
    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selectedBlock) {
        self.selectedBlock(indexPath.row,_viewtype);
    }
}

@end
