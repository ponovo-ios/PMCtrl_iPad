//
//  BD_SMV60044Cell.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/11.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_SMV60044Cell.h"
#import "UITextField+Extension.h"
@implementation BD_SMV60044Cell

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
    if (sender.tag == 100) {
        [sender setSelected:!sender.selected];
    } else {
        //通道光口  3 通道数  5 状态字1  7 状态字2 8
        switch (sender.tag) {
            case 3:
                //通道光口选择
                break;
            case 5:
                //通道数
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
}
-(void)setDataToCellView:(BD_IECGooseSMVModel_60044Model *)cellData{
    
    [self viewTagToTF:2].text = cellData.LDName;
    [self viewTagToTF:2].text = cellData.describe;
    [[self viewTagToBtn:3] setTitle:cellData.opticalport forState:UIControlStateNormal];
    [self viewTagToTF:4].text = cellData.dataSetName;
    [[self viewTagToBtn:5]setTitle:cellData.passageNum forState:UIControlStateNormal];
    [self viewTagToTF:6].text = cellData.ratedDelayTime;
    [[self viewTagToBtn:7]setTitle:cellData.stateObject1 forState:UIControlStateNormal];
    [[self viewTagToBtn:8]setTitle:cellData.stateObject2 forState:UIControlStateNormal];
    //bool类型赋值
    [[self viewTagToBtn:100] setSelected:cellData.isTransmit];
    
}

@end
