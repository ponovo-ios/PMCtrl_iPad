//
//  BD_HarmDataCell.m
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/12/1.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_HarmDataCell.h"

@interface BD_HarmDataCell()<UITextFieldDelegate>
{
    UITextField *_tempTF;
    NSString *_originalValue;
}

@property (weak, nonatomic) IBOutlet UITextField *firstValidValuesTF;
@property (weak, nonatomic) IBOutlet UITextField *firstPhaseTF;


@property (weak, nonatomic) IBOutlet UITextField *secondValidValuesTF;
@property (weak, nonatomic) IBOutlet UITextField *secondPhaseTF;


@property (weak, nonatomic) IBOutlet UITextField *thirdValidValuesTF;
@property (weak, nonatomic) IBOutlet UITextField *thirdPhaseTF;


@property (weak, nonatomic) IBOutlet UITextField *fourthValidValuesTF;
@property (weak, nonatomic) IBOutlet UITextField *fourthPhaseTF;

@end

@implementation BD_HarmDataCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.firstContainingRateTF.text = @"0.00";
    self.firstValidValuesTF.text = @"0.000";
    self.firstPhaseTF.text = @"0.0";
    
    self.secondContainingRateTF.text = @"0.00";
    self.secondValidValuesTF.text = @"0.000";
    self.secondPhaseTF.text = @"0.0";
    
    self.thirdContainingRateTF.text = @"0.00";
    self.thirdValidValuesTF.text = @"0.000";
    self.thirdPhaseTF.text = @"0.0";
    
    self.fourthContainingRateTF.text = @"0.00";
    self.fourthValidValuesTF.text = @"0.000";
    self.fourthPhaseTF.text = @"0.0";
    
}

-(void)setCellModel:(BD_HarmCellModel *)cellModel
{
    _cellModel = cellModel;
    //第一个item
    BD_HarmItem *firstItem = cellModel.itemArray.firstObject;
    self.firstContainingRateTF.text = firstItem.containingRate;
    self.firstValidValuesTF.text = firstItem.validValues;
    self.firstPhaseTF.text = firstItem.phase;
    //第二个item
    BD_HarmItem *secondItem = cellModel.itemArray[1];
    self.secondContainingRateTF.text = secondItem.containingRate;
    self.secondValidValuesTF.text = secondItem.validValues;
    self.secondPhaseTF.text = secondItem.phase;
    //第三个item
    BD_HarmItem *thirdItem = cellModel.itemArray[2];
    self.thirdContainingRateTF.text = thirdItem.containingRate;
    self.thirdValidValuesTF.text = thirdItem.validValues;
    self.thirdPhaseTF.text = thirdItem.phase;
    
    if (cellModel.itemArray.count == 4) {
        //第四个item
        BD_HarmItem *fourthItem = cellModel.itemArray.lastObject;
        self.fourthContainingRateTF.text = fourthItem.containingRate;
        self.fourthValidValuesTF.text = fourthItem.validValues;
        self.fourthPhaseTF.text = fourthItem.phase;
    }
}


- (IBAction)selectBtnClick:(UIButton *)sender {
//    sender.selected = !sender.selected;
    self.clickSelectBtn(self.index, sender);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark-懒加载
-(NSArray<NSNumber *> *)limitValueArr{
    if (!_limitValueArr) {
        _limitValueArr = [[NSArray alloc]init];
    }
    return _limitValueArr;
}

//回退操作
-(void)goBack
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _tempTF.text = _originalValue;
        [self textFieldDidEndEditing:_tempTF];
    });

}



#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    //记录修改数据之前的值
    _originalValue = textField.text;
    
    //实现赋值及动态计算含有率与实际数值
    _tempTF = textField;
    
    //基波
    BD_HarmItem *baseFirstItem = self.baseCellModel.itemArray.firstObject;
    BD_HarmItem *baseSecondItem = self.baseCellModel.itemArray[1];
    BD_HarmItem *baseThirdItem = self.baseCellModel.itemArray[2];
    BD_HarmItem *baseFourthItem = self.baseCellModel.itemArray.lastObject;
    
    //选中模型
    BD_HarmItem *firstItem = self.cellModel.itemArray.firstObject;
    BD_HarmItem *secondItem = self.cellModel.itemArray[1];
    BD_HarmItem *thirdItem = self.cellModel.itemArray[2];
    BD_HarmItem *fourthItem = self.cellModel.itemArray.lastObject;
    
    switch (textField.tag) {
        case 0:
            firstItem.containingRate = @"0.00";
            firstItem.validValues = [NSString stringWithFormat:@"%.3f", baseFirstItem.validValues.floatValue * firstItem.containingRate.floatValue * 0.01];
            break;
        case 1:
            firstItem.validValues = @"0.000";
            firstItem.containingRate = [NSString stringWithFormat:@"%.2f", baseFirstItem.validValues.floatValue==0.00?0.00:firstItem.validValues.floatValue * 100 / baseFirstItem.validValues.floatValue];
            break;
        case 2:
            firstItem.phase = textField.text;
            break;
        case 3:
            secondItem.containingRate = @"0.00";
            secondItem.validValues = [NSString stringWithFormat:@"%.3f", baseSecondItem.validValues.floatValue * secondItem.containingRate.floatValue * 0.01];
            break;
        case 4:
            secondItem.validValues = @"0.000";
            secondItem.containingRate = [NSString stringWithFormat:@"%.2f", baseSecondItem.validValues.floatValue==0.00?0.00:secondItem.validValues.floatValue * 100 / baseSecondItem.validValues.floatValue];
            break;
        case 5:
            secondItem.phase = textField.text;
            break;
        case 6:
            thirdItem.containingRate = @"0.00";
            self.thirdValidValuesTF.text = thirdItem.validValues = [NSString stringWithFormat:@"%.3f", baseThirdItem.validValues.floatValue * thirdItem.containingRate.floatValue * 0.01];
            break;
        case 7:
            thirdItem.validValues = @"0.000";
            thirdItem.containingRate = [NSString stringWithFormat:@"%.2f", baseThirdItem.validValues.floatValue==0.00?0.00:thirdItem.validValues.floatValue * 100 / baseThirdItem.validValues.floatValue];
            break;
        case 8:
            thirdItem.phase = textField.text;
            break;
        case 9:
            fourthItem.containingRate = @"0.00";
            fourthItem.validValues = [NSString stringWithFormat:@"%.3f", baseFourthItem.validValues.floatValue * fourthItem.containingRate.floatValue * 0.01];
            break;
        case 10:
            fourthItem.validValues = @"0.000";
            fourthItem.containingRate = [NSString stringWithFormat:@"%.2f", baseFourthItem.validValues.floatValue==0.00?0.00:fourthItem.validValues.floatValue * 100 / baseFourthItem.validValues.floatValue];
            break;
        case 11:
            fourthItem.phase = textField.text;
            break;
        default:
            break;
    }
    
    if (self.editDelegate&&[self.editDelegate respondsToSelector:@selector(getLimitValues)]) {
        self.limitValueArr = [self.editDelegate getLimitValues];
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //获取变化后的字符串
    NSString * newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
   
    if (textField.tag == 1 || textField.tag == 4 || textField.tag == 7 || textField.tag == 10) {
       //有效值
       
        if (_limitValueArr.count>=3) {
            switch (textField.tag) {
                case 1:
                {
                    if(newText.floatValue<-0.000){
                        textField.text = @"0.000";
                        return NO;
                    } else if (newText.floatValue>_limitValueArr[0].floatValue) {
                        textField.text = kTStrings(_limitValueArr[0].floatValue);
                        return NO;
                    }
                }
                    break;
                case 4:
                {
                    if(newText.floatValue<-0.000){
                        textField.text = @"0.000";
                        return NO;
                    } else if (newText.floatValue>_limitValueArr[1].floatValue) {
                        textField.text = kTStrings(_limitValueArr[1].floatValue);
                        return NO;
                    }
                }
                    break;
                case 7:
                {
                    if(newText.floatValue<-0.000){
                        textField.text = @"0.000";
                        return NO;
                    } else if (newText.floatValue>_limitValueArr[2].floatValue) {
                        textField.text = kTStrings(_limitValueArr[2].floatValue);
                        return NO;
                    }
                }
                    break;
                case 10:
                {
                    if(newText.floatValue<-0.000){
                        textField.text = @"0.000";
                        return NO;
                    } else if (newText.floatValue>_limitValueArr[3].floatValue) {
                        textField.text = kTStrings(_limitValueArr[3].floatValue);
                        return NO;
                    }
                }
                    break;
                default:
                    break;
            }
        }
    }else if (textField.tag == 0 || textField.tag == 3 || textField.tag == 6 || textField.tag == 9){
      //含有率

        if (newText.floatValue<0.000){
            textField.text = @"0.0043";
            return NO;
        }
      
    }else{
      //相位
        if (newText.floatValue>180){
            textField.text = @"180.000";
            return NO;
        } else if (newText.floatValue<-180){
            textField.text = @"-180.000";
            return NO;
        }
    }
    
    //添加只能数字的约束
    if ([[BD_Utils shared] validateNumber:string] == NO) {
        [MBProgressHUDUtil showMessage:@"请输入有效字符" toView:self];
        return NO;
    } else {
        return [[BD_Utils shared]validateNumber:string];
    }
    
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    _tempTF = textField;
    
    //基波
    BD_HarmItem *baseFirstItem = self.baseCellModel.itemArray.firstObject;
    BD_HarmItem *baseSecondItem = self.baseCellModel.itemArray[1];
    BD_HarmItem *baseThirdItem = self.baseCellModel.itemArray[2];
    BD_HarmItem *baseFourthItem = self.baseCellModel.itemArray.lastObject;
    
    //选中模型
    BD_HarmItem *firstItem = self.cellModel.itemArray.firstObject;
    BD_HarmItem *secondItem = self.cellModel.itemArray[1];
    BD_HarmItem *thirdItem = self.cellModel.itemArray[2];
    BD_HarmItem *fourthItem = self.cellModel.itemArray.lastObject;
    
    if (textField.tag == 1 || textField.tag == 4 || textField.tag == 7 || textField.tag == 10) {
        textField.text = [NSString stringWithFormat:@"%.3f", textField.text.floatValue];
    }else if (textField.tag == 0 || textField.tag == 3 || textField.tag == 6 || textField.tag == 9){
        textField.text = [NSString stringWithFormat:@"%.2f", textField.text.floatValue];
    }else{
        textField.text = [NSString stringWithFormat:@"%.1f", textField.text.floatValue];
    }
   
    //实现赋值及动态计算含有率与实际数值
    switch (textField.tag) {
        case 0:
            firstItem.containingRate = textField.text;
            self.firstValidValuesTF.text = firstItem.validValues = [NSString stringWithFormat:@"%.3f", baseFirstItem.validValues.floatValue * firstItem.containingRate.floatValue * 0.01];
            break;
        case 1:
            firstItem.validValues = textField.text;
            self.firstContainingRateTF.text = firstItem.containingRate = [NSString stringWithFormat:@"%.2f", baseFirstItem.validValues.floatValue==0.00?0.00:firstItem.validValues.floatValue * 100 / baseFirstItem.validValues.floatValue];
            break;
        case 2:
            firstItem.phase = textField.text;
            break;
        case 3:
            secondItem.containingRate = textField.text;
            self.secondValidValuesTF.text = secondItem.validValues = [NSString stringWithFormat:@"%.3f", baseSecondItem.validValues.floatValue * secondItem.containingRate.floatValue * 0.01];
            break;
        case 4:
            secondItem.validValues = textField.text;
            self.secondContainingRateTF.text = secondItem.containingRate = [NSString stringWithFormat:@"%.2f", baseSecondItem.validValues.floatValue==0.00?0.00:secondItem.validValues.floatValue * 100 / baseSecondItem.validValues.floatValue];
            break;
        case 5:
            secondItem.phase = textField.text;
            break;
        case 6:
            thirdItem.containingRate = textField.text;
            self.thirdValidValuesTF.text = thirdItem.validValues = [NSString stringWithFormat:@"%.3f", baseThirdItem.validValues.floatValue * thirdItem.containingRate.floatValue * 0.01];
            break;
        case 7:
            thirdItem.validValues = textField.text;
            self.thirdContainingRateTF.text = thirdItem.containingRate = [NSString stringWithFormat:@"%.2f", baseThirdItem.validValues.floatValue==0.00?0.00:thirdItem.validValues.floatValue * 100 / baseThirdItem.validValues.floatValue];
            break;
        case 8:
            thirdItem.phase = textField.text;
            break;
        case 9:
            fourthItem.containingRate = textField.text;
            self.fourthValidValuesTF.text = fourthItem.validValues = [NSString stringWithFormat:@"%.3f", baseFourthItem.validValues.floatValue * fourthItem.containingRate.floatValue * 0.01];
            break;
        case 10:
            fourthItem.validValues = textField.text;
            self.fourthContainingRateTF.text = fourthItem.containingRate = [NSString stringWithFormat:@"%.2f", baseFourthItem.validValues.floatValue==0.00?0.00:fourthItem.validValues.floatValue * 100 / baseFourthItem.validValues.floatValue];
            break;
        case 11:
            fourthItem.phase = textField.text;
            break;
        default:
            break;
    }
    
    //修改tableData 头部总有效值
    self.changeValue(textField.tag / 3);
}

@end
