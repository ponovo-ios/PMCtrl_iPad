//
//  BD_SMV618502Cell.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/11.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_SMV618502Cell.h"
#import "UITextField+Extension.h"
@implementation BD_SMV618502Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    for (int i = 1; i<=13; i++) {
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
        case 7:
            //输出口选择
            break;
        case 11:
            //同步方式
            break;
        default:
            break;
    }
}
-(void)setDataToCellView:(BD_IECGooseSMVModel_618502Model *)cellData{

    [self viewTagToTF:1].text = cellData.targeMACAddress;
    [self viewTagToTF:2].text = cellData.sourceMACAddress;
    [self viewTagToTF:3].text = cellData.APPID;
    [self viewTagToTF:4].text = cellData.samplingDelayTime;
    [self viewTagToTF:5].text = cellData.Vlan_priority;
    [self viewTagToTF:6].text = cellData.Vlan_id;
    [[self viewTagToBtn:7] setTitle:cellData.outputPort forState:UIControlStateNormal];
    [self viewTagToTF:8].text = cellData.describe;
    [self viewTagToTF:9].text = cellData.passageNum;
    [self viewTagToTF:10].text = cellData.version;
    [[self viewTagToBtn:11] setTitle:cellData.synchronousStyle forState:UIControlStateNormal];
    [self viewTagToTF:12].text = cellData.svId;
    [self viewTagToTF:13].text = cellData.datSet;
    //bool类型赋值
    [[self viewTagToBtn:100] setSelected:cellData.isTransmit];
    
}

@end
