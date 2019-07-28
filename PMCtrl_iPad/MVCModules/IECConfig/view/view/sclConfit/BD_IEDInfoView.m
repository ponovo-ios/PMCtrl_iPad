//
//  BD_IEDInfoView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/4.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_IEDInfoView.h"
#import "BD_IEDInfoTBScrollView.h"
#import "BD_IEDInfoModel.h"
#import "BD_SCLConfigCell.h"
#import "BD_IECSMVSCLFormHeaderView.h"
#import "BD_IEDSelectedModel.h"
@interface BD_IEDInfoView()
@property (weak, nonatomic) IBOutlet UIButton *gooseSendBtn;
@property (weak, nonatomic) IBOutlet UIButton *smvSendBtn;
@property (weak, nonatomic) IBOutlet UIButton *gooseSubBtn;
@property (weak, nonatomic) IBOutlet UIButton *smvSubBtn;

@property (weak, nonatomic) IBOutlet UIButton *schematicBtn;
@property (weak, nonatomic) IBOutlet UIView *selectedMarkView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *markViewCenterlayout;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@property(nonatomic,strong)BD_IEDSelectedModel *currentCheckItem;
@end
@implementation BD_IEDInfoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib{
    [super awakeFromNib];
    _infoModel = [[BD_IEDInfoModel alloc]init];
    _currentCheckItem = [[BD_IEDSelectedModel alloc]init];
    [self loadTBViews];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _gooseSendTBView.frame = CGRectMake(0, 0, self.scrollView.width, self.scrollView.height);
    _smvSendTBView.frame = CGRectMake(self.scrollView.width, 0, self.scrollView.width, self.scrollView.height);
    _gooseSubTBView.frame = CGRectMake(self.scrollView.width*2, 0, self.scrollView.width, self.scrollView.height);
    _smvSubTBView.frame = CGRectMake(self.scrollView.width*3, 0, self.scrollView.width, self.scrollView.height);
    _scrollView.contentOffset = CGPointMake(0, 0);
}

- (IBAction)gooseSendAction:(id)sender {
    self.markViewCenterlayout.constant = 0;
    [self confitBtnSelectedToGooseSend:YES gooseSubBtnState:NO smvSendBtnState:NO smvSubBtnState:NO schematicBtnState:NO];
    self.scrollView.contentOffset = CGPointMake(0,0);
}
- (IBAction)gooseSubAction:(id)sender {
    self.markViewCenterlayout.constant = CGRectGetMidX(((UIButton *)sender).frame) -CGRectGetMidX(self.gooseSendBtn.frame);
    [self confitBtnSelectedToGooseSend:NO gooseSubBtnState:YES smvSendBtnState:NO smvSubBtnState:NO schematicBtnState:NO];
     self.scrollView.contentOffset = CGPointMake(self.scrollView.width*2,0);
}


- (IBAction)smvSendAction:(id)sender {
       self.markViewCenterlayout.constant = CGRectGetMidX(((UIButton *)sender).frame) -CGRectGetMidX(self.gooseSendBtn.frame);
    [self confitBtnSelectedToGooseSend:NO gooseSubBtnState:NO smvSendBtnState:YES smvSubBtnState:NO schematicBtnState:NO];
     self.scrollView.contentOffset = CGPointMake(self.scrollView.width,0);
    //点击后，默认选中第一行
    if (self.iedInfoSelectedBlock) {
        self.iedInfoSelectedBlock(0,BD_IEDInfoType_SMVSend);
    }
}
- (IBAction)smvSubAction:(id)sender {
       self.markViewCenterlayout.constant = CGRectGetMidX(((UIButton *)sender).frame) -CGRectGetMidX(self.gooseSendBtn.frame);
    [self confitBtnSelectedToGooseSend:NO gooseSubBtnState:NO smvSendBtnState:NO smvSubBtnState:YES schematicBtnState:NO];
     self.scrollView.contentOffset = CGPointMake(self.scrollView.width*3,0);
}

- (IBAction)schematicAction:(id)sender {
       self.markViewCenterlayout.constant = CGRectGetMidX(((UIButton *)sender).frame) -CGRectGetMidX(self.gooseSendBtn.frame);
    [self confitBtnSelectedToGooseSend:NO gooseSubBtnState:NO smvSendBtnState:NO smvSubBtnState:NO schematicBtnState:YES];
//     self.scrollView.contentOffset = CGPointMake(self.scrollView.width*4,0);
}



-(void)confitBtnSelectedToGooseSend:(BOOL)gooseSendState gooseSubBtnState:(BOOL) gooseSubBtnState smvSendBtnState:(BOOL)smvSendBtnState smvSubBtnState:(BOOL)smvSubBtnState schematicBtnState:(BOOL)schematicBtnState{
    self.gooseSendBtn.selected = gooseSendState;
    self.gooseSubBtn.selected = gooseSubBtnState;
    self.smvSendBtn.selected = smvSendBtnState;
    self.smvSubBtn.selected = smvSubBtnState;
    self.schematicBtn.selected = schematicBtnState;
}

-(void)loadTBViews{
    WeakSelf;
    _gooseSendTBView = [[BD_IEDInfoTBScrollView alloc]initWithData:[self.infoModel.GSEList copy]];
    _gooseSendTBView.headerTitles = @[@"序号",@"APPID",@"MAC",@"控制块所在AP",@"通道数",@"数据集描述",@"数据集",@"goID",@"gocbRef",@"VLAN-ID",@"VLAN Priority",@"confRev"];
    _gooseSendTBView.iedInfoArr = [self.infoModel.GSEList copy];
    _gooseSendTBView.viewtype = BD_IEDInfoType_GOSend;
    _gooseSendTBView.selectedBlock = ^(NSInteger index, BD_IEDInfoType viewType) {
        if (weakself.iedInfoSelectedBlock) {
            weakself.iedInfoSelectedBlock(index, viewType);
        }
    };
    _gooseSendTBView.checkedBlock = ^(NSInteger index, BD_IEDInfoType viewType,BOOL state) {
        if (weakself.iedInfoCheckBlock) {
            BD_IEDSelectedModel *checkItem;
            if (state) {
                checkItem = [[BD_IEDSelectedModel alloc]init];
                checkItem.iedType = [[[BD_Utils alloc]init] enumIEDTypeToString:viewType];
                checkItem.APPID = ((BD_GSEInfo *)[weakself viewTypeToArray:viewType index:index]).APPID;
                checkItem.dataSetDesc =((BD_GSEInfo *)[weakself viewTypeToArray:viewType index:index]).DataSetDesc;
                weakself.currentCheckItem = checkItem;
            }
            weakself.iedInfoCheckBlock(weakself.currentCheckItem,state);
            
        }
    };
    _smvSendTBView = [[BD_IEDInfoTBScrollView alloc]initWithData:[self.infoModel.SMVList copy]];
    _smvSendTBView.headerTitles = @[@"序号",@"APPID",@"MAC",@"控制块所在AP",@"通道数",@"数据集描述",@"数据集路径",@"svID",@"VLAN-ID",@"VLAN Priority",@"confRev",@"NofASDU",@"SmpRate"];
    _smvSendTBView.iedInfoArr = [self.infoModel.SMVList copy];
    _smvSendTBView.viewtype = BD_IEDInfoType_SMVSend;
    _smvSendTBView.selectedBlock = ^(NSInteger index, BD_IEDInfoType viewType) {
        if (weakself.iedInfoSelectedBlock) {
            weakself.iedInfoSelectedBlock(index, viewType);
        }
    };
    _smvSendTBView.checkedBlock = ^(NSInteger index, BD_IEDInfoType viewType,BOOL state) {
        if (weakself.iedInfoCheckBlock) {
            
            if (state) {
                BD_IEDSelectedModel *checkItem;
                checkItem = [[BD_IEDSelectedModel alloc]init];
                checkItem.iedType = [[[BD_Utils alloc]init] enumIEDTypeToString:viewType];
                checkItem.APPID = ((BD_SMVInfo *)[weakself viewTypeToArray:viewType index:index]).APPID;
                checkItem.dataSetDesc =((BD_SMVInfo *)[weakself viewTypeToArray:viewType index:index]).DataSetDesc;
                weakself.currentCheckItem = checkItem;
            }
           
            weakself.iedInfoCheckBlock(weakself.currentCheckItem,state);
        }
    };
    
    _gooseSubTBView = [[BD_IEDInfoTBScrollView alloc]init];
    _gooseSubTBView.headerTitles = @[@"序号",@"APPID",@"MAC",@"控制块所在AP",@"通道数",@"外部通道数",@"外部IED名称",@"数据集描述",@"数据集",@"goID",@"gocbRef",@"VLAN-ID",@"VLAN Priority",@"confRev"];
    _gooseSubTBView.viewtype = BD_IEDInfoType_GOSub;
    _gooseSubTBView.selectedBlock = ^(NSInteger index, BD_IEDInfoType viewType) {
        if (weakself.iedInfoSelectedBlock) {
            weakself.iedInfoSelectedBlock(index, viewType);
        }
    };
    
    _smvSubTBView = [[BD_IEDInfoTBScrollView alloc]init];
    _smvSubTBView.headerTitles = @[@"序号",@"APPID",@"MAC",@"控制块所在AP",@"通道数",@"外部通道数",@"外部IED名称",@"svID",@"数据集",@"数据集描述",@"smpRate"];
    _smvSubTBView.viewtype = BD_IEDInfoType_SMVSub;
    _smvSubTBView.selectedBlock = ^(NSInteger index, BD_IEDInfoType viewType) {
        if (weakself.iedInfoSelectedBlock) {
            weakself.iedInfoSelectedBlock(index, viewType);
        }
    };
    
    [self.scrollView addSubview:_gooseSendTBView];
    [self.scrollView addSubview:_smvSendTBView];
    [self.scrollView addSubview:_gooseSubTBView];
    [self.scrollView addSubview:_smvSubTBView];

    self.scrollView.contentSize = CGSizeMake(self.scrollView.width*4,self.scrollView.height);
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.scrollEnabled = NO;
}

-(void)setInfoModel:(BD_IEDInfoModel *)infoModel{
    _infoModel = infoModel;
    _gooseSendTBView.iedInfoArr = [self.infoModel.GSEList copy];
    _smvSendTBView.iedInfoArr = [self.infoModel.SMVList copy];
    if (self.infoModel.GSEList.count==0) {
        [[[BD_Utils alloc] init] setViewState:NO view:_gooseSendBtn];
    } else {
        [[[BD_Utils alloc] init] setViewState:YES view:_gooseSendBtn];
    }
    if (self.infoModel.SMVList.count==0) {
       [[[BD_Utils alloc] init] setViewState:NO view:_smvSendBtn];
    } else {
        [[[BD_Utils alloc] init] setViewState:YES view:_smvSendBtn];
    }
    
}

//点击IED列表刷新ied信息
-(void)reloadViewData{
    self.markViewCenterlayout.constant = 0;
    [self confitBtnSelectedToGooseSend:YES gooseSubBtnState:NO smvSendBtnState:NO smvSubBtnState:NO schematicBtnState:NO];
    self.scrollView.contentOffset = CGPointMake(0,0);
    [_gooseSubTBView reloadTBData];
    [_gooseSendTBView reloadTBData];
    [_smvSendTBView reloadTBData];
    [_smvSubTBView reloadTBData];
    [_gooseSendTBView selectedFirstItem];
    [_smvSendTBView selectedFirstItem];
}

-(nullable id)viewTypeToArray:(BD_IEDInfoType )viewType index:(NSInteger)index{
    if (viewType == BD_IEDInfoType_GOSend) {
        BD_GSEInfo *gse = _infoModel.GSEList[index];
        return gse;
    } else if (viewType == BD_IEDInfoType_SMVSend){
        BD_SMVInfo *smv = _infoModel.SMVList[index];
        return smv;
    } else {
        return nil;
    }
}
@end
