//
//  BD_GooseTransmitSCLFormCell.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/5.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_GooseTransmitSCLFormCell.h"
#import "UITextField+Extension.h"
@interface BD_GooseTransmitSCLFormCell()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation BD_GooseTransmitSCLFormCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _bgView.backgroundColor = ClearColor;
    for (int i = 1; i<=13; i++) {
        //i = 6 输出光口选择
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
    //测试
    [self setBtnImage:@"unselected_square" selectedImage:@"selected_square" viewTag:110];
    [self setBtnActionWithTag:110];
    //ndsCom
    [self setBtnImage:@"unselected_square" selectedImage:@"selected_square" viewTag:120];
    [self setBtnActionWithTag:120];
    
    
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


//cell 中 button的事件，统一使用
-(void)cellBtnClick:(UIButton *)sender{
    [super cellBtnClick:sender];
    if (sender.tag == 100 || sender.tag == 110 || sender.tag == 120) {
        [sender setSelected:!sender.selected];
    }
    if (sender.tag == 6) {
        //输出光口选择
    }
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
}

-(void)setDataToCellView:(BD_IECGooseTransmitSCLDataModel *)cellData{
    //tag根据UI设计，从左到右1--13 选择框tag为100---120
    [self viewTagToTF:1].text = cellData.targeMACAddress;
    [self viewTagToTF:2].text = cellData.souceMACAddress;
    [self viewTagToTF:3].text = cellData.APPID;
    [self viewTagToTF:4].text = cellData.Vlan_priority;
    [self viewTagToTF:5].text = cellData.Vlan_id;
    [[self viewTagToBtn:6] setTitle:cellData.outputOpticalport forState:UIControlStateNormal];
    [self viewTagToTF:7].text = cellData.describe;
    [self viewTagToTF:8].text = cellData.passageNum;
    [self viewTagToTF:9].text = cellData.version;
    [self viewTagToTF:10].text = cellData.gocbRef;
    [self viewTagToTF:11].text = cellData.datSet;
    [self viewTagToTF:12].text = cellData.goId;
    [self viewTagToTF:13].text = cellData.alowExistTime;
    
    [[self viewTagToBtn:100] setSelected:cellData.isTransmit];
    [[self viewTagToBtn:110] setSelected:cellData.isTest];
    [[self viewTagToBtn:120] setSelected:cellData.ndsCom];
}
@end
