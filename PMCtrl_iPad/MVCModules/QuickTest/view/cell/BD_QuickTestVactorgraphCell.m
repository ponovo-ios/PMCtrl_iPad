//
//  BD_QuickTestVactorgraphCell.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/17.
//  Copyright © 2017年 ponovo. All rights reserved.
//



#import "BD_QuickTestVactorgraphCell.h"
#import "BD_VactorgraphViewDataCell.h"
#import "BD_TestDataParamModel.h"
#import "BD_VectorgraphDrawView.h"
#import "BD_QuickTestVactorgraphModel.h"
#import "BD_VectorMaxValueModel.h"
#import "UITextField+Extension.h"
@interface BD_QuickTestVactorgraphCell()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{

    
}

@property (weak, nonatomic) IBOutlet BD_VectorgraphDrawView *drawView;
@property (weak, nonatomic) IBOutlet UIView *drawPictureView;
@property (weak, nonatomic) IBOutlet UITextField *UMaxValue;
@property (weak, nonatomic) IBOutlet UITextField *IMaxValue;

@end
@implementation BD_QuickTestVactorgraphCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _voltageSelectedArr = [[NSMutableArray alloc]init];
    _currentSelectedArr = [[NSMutableArray alloc]init];
    
    self.backgroundColor = ClearColor;
    self.contentView.backgroundColor = ClearColor;
    [self.btnContainerView setCorenerRadius:10.0 borderColor:BtnViewBorderColor borderWidth:2.0];
    [self.bgView setCorenerRadius:2 borderColor:Black borderWidth:2.0];
    
    self.bgView.backgroundColor = [UIColor colorWithRed:42.0/255.0 green:41.0/255.0 blue:42.0/255.0 alpha:1.0];

    self.btnContainerView.backgroundColor = ClearColor;
    self.cellTableView.backgroundColor = ClearColor;
    _cellTableView.delegate = self;
    _cellTableView.dataSource = self;
    _cellTableView.bounces = NO;
    [_cellTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BD_VactorgraphViewDataCell class]) bundle:nil] forCellReuseIdentifier:@"BD_VactorgraphViewDataCellID"];
    [_UMaxValue setDefaultSetting];
    [_IMaxValue setDefaultSetting];
    // Initialization code
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

-(void)confitView{
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchGeture:)];
    [self.drawPictureView addGestureRecognizer:pinch];
    
}

#pragma mark - 懒加载
-(NSArray<NSString *> *)titleArr{
    if (!_titleArr) {
        _titleArr  = [[NSArray alloc]init];
    }
    
    return _titleArr;
}

-(BD_QuickTestVactorgraphModel *)vactorgraphData{
    if (!_vactorgraphData) {
        _vactorgraphData = [[BD_QuickTestVactorgraphModel alloc]init];
    }
    
    return _vactorgraphData;
}

-(BD_VectorMaxValueModel *)MAXAmplitudeModel{
    if (!_MAXAmplitudeModel) {
        _MAXAmplitudeModel = [[BD_VectorMaxValueModel alloc]init];
    }
    return _MAXAmplitudeModel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setCellData{
    [_UMaxValue setDefaultSetting];
    [_IMaxValue setDefaultSetting];

    if ([_UMaxValue.text floatValue]<[self getUMaxValue]) {
        _UMaxValue.text = kTStrings([self getUMaxValue]);
        
    }
    self.MAXAmplitudeModel.U_Max = [_UMaxValue.text floatValue];
    
    if ([_IMaxValue.text floatValue]<[self getIMaxValue]) {
        _IMaxValue.text = kTStrings([self getIMaxValue]);
    }
    self.MAXAmplitudeModel.I_Max = [_IMaxValue.text floatValue];
    
    
    _UMaxValue.text = kTStrings(self.MAXAmplitudeModel.U_Max);
    _IMaxValue.text = kTStrings(self.MAXAmplitudeModel.I_Max);
    
    _drawView.MAX_UAmplitude = self.MAXAmplitudeModel.U_Max;
    _drawView.MAX_IAmplitude =self.MAXAmplitudeModel.I_Max;
    [_drawView setNeedsDisplay];
    
    _UMaxValue.delegate = self;
    _IMaxValue.delegate = self;
    
    _drawView.MAX_UAmplitude = self.MAXAmplitudeModel.U_Max;
    _drawView.MAX_IAmplitude = self.MAXAmplitudeModel.I_Max;
    [self confitView];
    
    [_cellTableView reloadData];
    NSMutableArray *vecdata = [[NSMutableArray alloc]initWithArray:[_vactorgraphData.voltageArr copy]];
    [vecdata addObjectsFromArray:[_vactorgraphData.currentArr copy]];
    self.drawView.viewDatas = [vecdata copy];
    
    NSMutableArray *vecSel = [[NSMutableArray alloc]initWithArray:[_voltageSelectedArr copy]];
    [vecSel addObjectsFromArray:[_currentSelectedArr copy]];
    self.drawView.viewSelectedArr = [vecSel copy];
    [self.drawView setNeedsDisplay];//修改完数据源后，必须刷新view
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _vactorgraphData.voltageArr.count+_vactorgraphData.currentArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    }
//    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    BD_QuickTestBLVView *cellView = [[NSBundle mainBundle]loadNibNamed:@"BD_QuickTestBLVView" owner:self options:nil].lastObject;
//    cellView.frame = cell.contentView.bounds;
//
//    NSArray *colorArr;
//    if (_vactorgraphData.voltageArr.count == 4) {
//        colorArr = @[Yellow,Green,Red,[UIColor blueColor],Yellow,Green,Red];
//    } else {
//        colorArr = @[Yellow,Green,Red,Yellow,Green,Red];
//    }
//
//
//
//    [ cellView setData:[_subCellSelectedArr[indexPath.row] boolValue] title:_titleArr[indexPath.row] lineColor:colorArr[indexPath.row]];
//
//    cell.contentView.backgroundColor = Black;
//    cellView.backgroundColor = ClearColor;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    [cell.contentView addSubview:cellView];
//    __weak typeof(_subCellSelectedArr) weaksubCellSelectedArr = _subCellSelectedArr;
//    __weak typeof (self) weakself = self;
//    cellView.blvSelectedBlock = ^(int viewtag, BOOL btnState) {
//        [weaksubCellSelectedArr replaceObjectAtIndex:indexPath.row withObject:@(btnState)];
//
//        [weakself.drawView.drawLineDic setObject:@(btnState) forKey:[_titleArr[indexPath.row] substringToIndex:2]];
//        [weakself.drawView setNeedsDisplay];
//    };
//    return cell;
    
    BD_VactorgraphViewDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BD_VactorgraphViewDataCellID" forIndexPath:indexPath];
    cell.cellIndex = (int)indexPath.row;
    
    NSArray<UIColor *> *colorArr;
    if ([tableView numberOfRowsInSection:0]==7) {
        //如果有Uz就用7个，无用6个
        colorArr = @[Yellow,Green,Red,[UIColor blueColor],Yellow,Green,Red];
    } else {
        colorArr = @[Yellow,Green,Red,Yellow,Green,Red];
    }
//    cell.lineMarkColorView.backgroundColor = colorArr[indexPath.row];
    

    CAShapeLayer *layer2 = [CAShapeLayer new];
    layer2.lineWidth = cell.lineMarkColorView.height;
    layer2.strokeColor = colorArr[indexPath.row].CGColor;
    layer2.fillColor = ClearColor.CGColor;
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(0,cell.lineMarkColorView.height/2)];
    [path2 addLineToPoint:CGPointMake(cell.lineMarkColorView.width, cell.lineMarkColorView.height/2)];
    layer2.path = [path2 CGPath];
    
    NSMutableArray *vecdata = [[NSMutableArray alloc]initWithArray:[_vactorgraphData.voltageArr copy]];
    [vecdata addObjectsFromArray:[_vactorgraphData.currentArr copy]];
    BD_TestDataParamModel *testmodel = (BD_TestDataParamModel *)vecdata[indexPath.row];
    cell.titleName.text = testmodel.titleName;
    cell.amplitudeValue.text = testmodel.amplitude;
    cell.phaseValue.text = testmodel.phase;
    cell.frequencyValue.text = testmodel.frequency;
   
   
    
    //电流通过虚线表示
//    if ([cell.titleName.text hasPrefix:@"I"]) {
//          [layer2 setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:2],[NSNumber numberWithInt:2], nil]];
//    }
//
//
    [cell.lineMarkColorView.layer addSublayer:layer2];
    
    if (_vactorgraphData.voltageArr.count != 0 && _vactorgraphData.currentArr.count != 0) {
        if (indexPath.row>[tableView numberOfRowsInSection:indexPath.section]-3-1) {
            BOOL state = [_currentSelectedArr[indexPath.row-_voltageSelectedArr.count] boolValue];
            [cell.selectedBtn setSelected:state];
        } else {
            BOOL state = [_voltageSelectedArr[indexPath.row] boolValue];
            [cell.selectedBtn setSelected:state];
        }
    }
    
    
    if (_vactorgraphData.voltageArr.count == 0) {
        [cell.selectedBtn setSelected:[_currentSelectedArr[indexPath.row] boolValue]];
    } else if (_vactorgraphData.currentArr.count == 0){
        [cell.selectedBtn setSelected:[_voltageSelectedArr[indexPath.row] boolValue]];
    }
    //选择是否显示矢量的线
    WeakSelf;
    cell.selectedBlock = ^(BOOL state, int cellIndex) {
        
        if (weakself.vactorgraphData.voltageArr.count != 0 && weakself.vactorgraphData.currentArr.count != 0) {
            if (cellIndex<[tableView numberOfRowsInSection:indexPath.section]-3) {
                [weakself.voltageSelectedArr replaceObjectAtIndex:cellIndex withObject:@(state)];
            } else {
                [weakself.currentSelectedArr replaceObjectAtIndex:cellIndex-weakself.voltageSelectedArr.count withObject:@(state)];
            }
        }
        
        if (weakself.vactorgraphData.voltageArr.count == 0) {
            [weakself.currentSelectedArr replaceObjectAtIndex:cellIndex withObject:@(state)];
        } else if (weakself.vactorgraphData.currentArr.count == 0){
            [weakself.voltageSelectedArr replaceObjectAtIndex:cellIndex withObject:@(state)];
        }
        
        weakself.selectedArrBlock(_cellIndex,[weakself.voltageSelectedArr copy], [weakself.currentSelectedArr copy]);
        
        NSMutableArray *vecdata = [[NSMutableArray alloc]initWithArray:[_vactorgraphData.voltageArr copy]];
        [vecdata addObjectsFromArray:[_vactorgraphData.currentArr copy]];
        self.drawView.viewDatas = [vecdata copy];
        
        NSMutableArray *vecSel = [[NSMutableArray alloc]initWithArray:[_voltageSelectedArr copy]];
        [vecSel addObjectsFromArray:[_currentSelectedArr copy]];
        self.drawView.viewSelectedArr = [vecSel copy];
        
        [weakself.drawView setNeedsDisplay];
        
    };
    
    if ( [cell.titleName.text hasPrefix:@"U"]) {
        cell.amplitudeLabel.text = @"幅值(V):";
    } else if ([cell.titleName.text hasPrefix:@"I"]){
        cell.amplitudeLabel.text = @"幅值(A):";
    }
    return cell;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}




-(void)reloadCellView{
    
    NSMutableArray *vecdata = [[NSMutableArray alloc]initWithArray:[_vactorgraphData.voltageArr copy]];
    [vecdata addObjectsFromArray:[_vactorgraphData.currentArr copy]];
    self.drawView.viewDatas = [vecdata copy];
    
    NSMutableArray *vecSel = [[NSMutableArray alloc]initWithArray:[_voltageSelectedArr copy]];
    [vecSel addObjectsFromArray:[_currentSelectedArr copy]];
    self.drawView.viewSelectedArr = [vecSel copy];
    
    
    _UMaxValue.text = kTStrings(self.MAXAmplitudeModel.U_Max);
    _IMaxValue.text = kTStrings(self.MAXAmplitudeModel.I_Max);
    
    if ([_UMaxValue.text floatValue]<[self getUMaxValue]) {
        _UMaxValue.text = kTStrings([self getUMaxValue]);
        
    }
    self.MAXAmplitudeModel.U_Max = [_UMaxValue.text floatValue];
    if ([_IMaxValue.text floatValue]<[self getIMaxValue]) {
        _IMaxValue.text = kTStrings([self getIMaxValue]);
        
    }
    self.MAXAmplitudeModel.I_Max = [_IMaxValue.text floatValue];
    
    _drawView.MAX_UAmplitude = self.MAXAmplitudeModel.U_Max;
    _drawView.MAX_IAmplitude = self.MAXAmplitudeModel.I_Max;
    
    [_drawView setNeedsDisplay];
    [self.cellTableView reloadData];
}

-(void)pinchGeture:(UIPinchGestureRecognizer *)recognizer{
    CGFloat scale = recognizer.scale;
    _UMaxValue.text = kTStrings([_UMaxValue.text floatValue]/scale);
    _IMaxValue.text = kTStrings([_IMaxValue.text floatValue]/scale);
    if ([_UMaxValue.text floatValue]<[self getUMaxValue]) {
        _UMaxValue.text = kTStrings([self getUMaxValue]);
        
    }
    self.MAXAmplitudeModel.U_Max = [_UMaxValue.text floatValue];
    if ([_IMaxValue.text floatValue]<[self getIMaxValue]) {
        _IMaxValue.text = kTStrings([self getIMaxValue]);
        
    }
    self.MAXAmplitudeModel.I_Max = [_IMaxValue.text floatValue];
    _drawView.MAX_UAmplitude = self.MAXAmplitudeModel.U_Max;
    _drawView.MAX_IAmplitude = self.MAXAmplitudeModel.I_Max;
    [_drawView setNeedsDisplay];
}
#pragma mark - textFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    //设置输入的数值为float类型
    textField.text = [NSString stringWithFormat:@"%0.3f",[textField.text floatValue]];
    if ([textField isEqual:_UMaxValue]) {
        if ([_UMaxValue.text floatValue]<[self getUMaxValue]) {
            _UMaxValue.text = kTStrings([self getUMaxValue]);
            
        }
        self.MAXAmplitudeModel.U_Max = [_UMaxValue.text floatValue];
    }
    if ([textField isEqual:_IMaxValue]) {
        if ([_IMaxValue.text floatValue]<[self getIMaxValue]) {
            _IMaxValue.text = kTStrings([self getIMaxValue]);
        }
        self.MAXAmplitudeModel.I_Max = [_IMaxValue.text floatValue];
    }
    _drawView.MAX_UAmplitude = self.MAXAmplitudeModel.U_Max;
    _drawView.MAX_IAmplitude =self.MAXAmplitudeModel.I_Max;
    [_drawView setNeedsDisplay];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    //添加只能数字的约束
    if ([[BD_Utils shared] validateNumber:string] == NO) {
        [MBProgressHUDUtil showMessage:@"请输入有效字符" toView:self];
        return NO;
    } else {
        return [[BD_Utils shared]validateNumber:string];
    }
    
    return YES;
}


-(CGFloat)getUMaxValue{
    CGFloat max_U = 0;
    for (BD_TestDataParamModel *model in self.vactorgraphData.voltageArr) {
        if ([model.amplitude floatValue]>max_U) {
            max_U = [model.amplitude floatValue];
        }
    }
    return max_U;
}

-(CGFloat)getIMaxValue{
    CGFloat max_I = 0;
    for (BD_TestDataParamModel *model in self.vactorgraphData.currentArr) {
        if ([model.amplitude floatValue]>max_I) {
            max_I = [model.amplitude floatValue];
        }
    }
    return max_I;
    
}

@end
