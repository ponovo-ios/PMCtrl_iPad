//
//  BD_VectorDiagramBaseView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/12.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_VectorDiagramBaseView.h"
#import "BD_TestDataParamModel.h"
#import "BD_VectorgraphDrawView.h"
#import "BD_FormTBViewCell.h"
#import "BD_FormTBViewHeaderView.h"
#import "BD_VectorMaxValueModel.h"
@interface BD_VectorDiagramBaseView()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *formTBView;
@property (weak, nonatomic) IBOutlet UIView *vectorPictureView;
@property (weak, nonatomic) IBOutlet BD_VectorgraphDrawView *vectorView;
@property (weak, nonatomic) IBOutlet UITextField *Umax;
@property (weak, nonatomic) IBOutlet UITextField *Imax;

@end

@implementation BD_VectorDiagramBaseView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = ClearColor;
    _formTBView.dataSource = self;
    _formTBView.delegate = self;
    _formTBView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _formTBView.bounces = NO;
    _formTBView.backgroundColor = ClearColor;
    
     [_formTBView registerClass:[BD_FormTBViewCell class] forCellReuseIdentifier:@"BD_FormTBViewCellID"];
    _Umax.text = kTStrings(self.MAXAmplitudeModel.U_Max);
    _Imax.text = kTStrings(self.MAXAmplitudeModel.I_Max);
    _Umax.delegate = self;
    _Imax.delegate = self;
    _vectorView.MAX_UAmplitude = self.MAXAmplitudeModel.U_Max;
    _vectorView.MAX_IAmplitude = self.MAXAmplitudeModel.I_Max;
    
    [self confitView];

}


-(void)confitView{
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchGeture:)];
    [self.vectorPictureView addGestureRecognizer:pinch];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}
#pragma mark -懒加载
-(NSArray *)formDataSource{
    if (!_formDataSource) {
        _formDataSource = [[NSArray alloc]init];
    }
    return _formDataSource;
}

-(NSArray<NSString *> *)headerViewTitles{
    if (!_headerViewTitles) {
        _headerViewTitles = [[NSArray alloc]init];
    }
    return _headerViewTitles;
}
-(BD_VectorMaxValueModel *)MAXAmplitudeModel{
    if (!_MAXAmplitudeModel) {
        _MAXAmplitudeModel = [[BD_VectorMaxValueModel alloc]init];
    }
    return _MAXAmplitudeModel;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _formDataSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BD_FormTBViewCell *cell;
    if (cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"BD_FormTBViewCellID" forIndexPath:indexPath];
    } else {
        cell = [[BD_FormTBViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BD_FormTBViewCellID" num:(int)_headerViewTitles.count];
    }
    NSArray *values = @[self.formDataSource[indexPath.row].titleName,self.formDataSource[indexPath.row].amplitude,self.formDataSource[indexPath.row].unit,self.formDataSource[indexPath.row].phase,self.formDataSource[indexPath.row].frequency];
    [cell.formArr enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.text = values[idx];
    }];
    cell.backgroundColor = ClearColor;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    BD_FormTBViewHeaderView *headerView = [[BD_FormTBViewHeaderView alloc]initWithNum:(int)_headerViewTitles.count];
    
    [headerView.formArr enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            obj.text = _headerViewTitles[idx];
        } else {
            obj.text = _headerViewTitles[idx];
        }
    }];
    headerView.backgroundColor = [UIColor lightGrayColor];
    return headerView;
}

-(void)reloadTBView{
    _vectorView.viewDatas = self.formDataSource;
    _Umax.text = kTStrings(self.MAXAmplitudeModel.U_Max);
    _Imax.text = kTStrings(self.MAXAmplitudeModel.I_Max);
    
    if ([_Umax.text floatValue]<[self getUMaxValue]) {
        _Umax.text = kTStrings([self getUMaxValue]);
        
    }
    self.MAXAmplitudeModel.U_Max = [_Umax.text floatValue];
    if ([_Imax.text floatValue]<[self getIMaxValue]) {
        _Imax.text = kTStrings([self getIMaxValue]);
        
    }
    self.MAXAmplitudeModel.I_Max = [_Imax.text floatValue];
   
    _vectorView.MAX_UAmplitude = self.MAXAmplitudeModel.U_Max;
    _vectorView.MAX_IAmplitude = self.MAXAmplitudeModel.I_Max;
    
    [_vectorView setNeedsDisplay];
    [self.formTBView reloadData];
}

-(void)pinchGeture:(UIPinchGestureRecognizer *)recognizer{
    CGFloat scale = recognizer.scale;
    _Umax.text = kTStrings([_Umax.text floatValue]/scale);
    _Imax.text = kTStrings([_Imax.text floatValue]/scale);
    if ([_Umax.text floatValue]<[self getUMaxValue]) {
        _Umax.text = kTStrings([self getUMaxValue]);
       
    }
     self.MAXAmplitudeModel.U_Max = [_Umax.text floatValue];
    if ([_Imax.text floatValue]<[self getIMaxValue]) {
        _Imax.text = kTStrings([self getIMaxValue]);
       
    }
     self.MAXAmplitudeModel.I_Max = [_Imax.text floatValue];
    _vectorView.MAX_UAmplitude = self.MAXAmplitudeModel.U_Max;
    _vectorView.MAX_IAmplitude = self.MAXAmplitudeModel.I_Max;
    [_vectorView setNeedsDisplay];
}
#pragma mark - textFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    //设置输入的数值为float类型
    textField.text = [NSString stringWithFormat:@"%0.3f",[textField.text floatValue]];
    if ([textField isEqual:_Umax]) {
        if ([_Umax.text floatValue]<[self getUMaxValue]) {
            _Umax.text = kTStrings([self getUMaxValue]);
            
        }
        self.MAXAmplitudeModel.U_Max = [_Umax.text floatValue];
    }
    if ([textField isEqual:_Imax]) {
        if ([_Imax.text floatValue]<[self getIMaxValue]) {
            _Imax.text = kTStrings([self getIMaxValue]);
        }
        self.MAXAmplitudeModel.I_Max = [_Imax.text floatValue];
    }
    _vectorView.MAX_UAmplitude = self.MAXAmplitudeModel.U_Max;
    _vectorView.MAX_IAmplitude =self.MAXAmplitudeModel.I_Max;
    [_vectorView setNeedsDisplay];
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
   
    for (BD_TestDataParamModel *model in self.formDataSource) {
        if ([model.titleName hasPrefix:@"U"]) {
            if ([model.amplitude floatValue]>max_U) {
                max_U = [model.amplitude floatValue];
            }
        }
    }
    return max_U;
}

-(CGFloat)getIMaxValue{
  
    CGFloat max_I = 0;
    
    for (BD_TestDataParamModel *model in self.formDataSource) {
        if ([model.titleName hasPrefix:@"I"]) {
            if ([model.amplitude floatValue]>max_I) {
                max_I = [model.amplitude floatValue];
            }
        }
    }
    return max_I;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
