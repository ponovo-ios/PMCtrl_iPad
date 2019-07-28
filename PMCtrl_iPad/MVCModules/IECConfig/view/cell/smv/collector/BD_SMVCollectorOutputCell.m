//
//  BD_SMVCollectorOutputCell.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/8.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_SMVCollectorOutputCell.h"
#import "UITextField+Extension.h"

@implementation BD_SMVCollectorOutputCell

- (void)awakeFromNib {
    [super awakeFromNib];
    for (int i = 1; i<=8; i++) {
        if ([[[self getViewFromTag:i] class] isEqual:[UIButton class]]) {
            UIButton *btn = (UIButton *)[self getViewFromTag:i];
            [btn setCorenerRadius:6 borderColor:White borderWidth:1];
            [self setBtnActionWithTag:i];
        } else if ([[[self getViewFromTag:i] class] isEqual:[UITextField class]]){
            UITextField *tf = (UITextField *)[self getViewFromTag:i];
            [tf setIECTFDefaultSetting];
            tf.clearButtonMode = UITextFieldViewModeWhileEditing;
        }
    }
    
    //是否发布
    [self setBtnImage:@"unselected_square" selectedImage:@"selected_square" viewTag:100];
    [self setBtnActionWithTag:100];
  
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)cellBtnClick:(UIButton *)sender{
    [super cellBtnClick:sender];
    switch (sender.tag) {
        case 100:
            [sender setSelected:!sender.selected];
            break;
        case 1:
           //互感器类型
            break;
        case 3:
          //光口
            break;
        case 6:
           //额定延时
            break;
        case 7:
            //状态字1
            break;
        case 8:
            //状态字2
            break;
            
        default:
            break;
    }
}
-(void)setDataToCellView:(BD_IECGooseSMVModel_CollectorOutputModel *)cellData{
    //tag根据UI设计，从左到右1--13 选择框tag为100---120
    
    [[self viewTagToBtn:1] setTitle:cellData.transformerType forState:UIControlStateNormal];
    [self viewTagToTF:2].text = cellData.describe;
    [[self viewTagToBtn:3] setTitle:cellData.opticalport forState:UIControlStateNormal];
    [self viewTagToTF:4].text = cellData.temperature;
    [self viewTagToTF:5].text = cellData.passageNum;
    [[self viewTagToBtn:6] setTitle:cellData.ratedDelayTime forState:UIControlStateNormal];
    [[self viewTagToBtn:7]setTitle:cellData.stateObject1 forState:UIControlStateNormal];
    [[self viewTagToBtn:8]setTitle:cellData.stateObject2 forState:UIControlStateNormal];
    //bool类型赋值
    [[self viewTagToBtn:100] setSelected:cellData.isTransmit];
   
}
@end
