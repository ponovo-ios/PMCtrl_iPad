//
//  BD_GooseSubSCLFormCell.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/29.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_GooseSubSCLFormCell.h"
#import "UITextField+Extension.h"
@interface BD_GooseSubSCLFormCell()
@property (weak, nonatomic) IBOutlet UITextField *macAddressTF;
@property (weak, nonatomic) IBOutlet UIView *bgview;


@end
@implementation BD_GooseSubSCLFormCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _bgview.backgroundColor = ClearColor;
    for (int i = 1; i<=10; i++) {
        if ([[[self getViewFromTag:i] class] isEqual:[UIButton class]]) {
            UIButton *btn = (UIButton *)[self getViewFromTag:i];
            [btn setCorenerRadius:6 borderColor:White borderWidth:1];
            //i == 3 订阅光口选择
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
    //是否解析GoCb,goID和Appid
    [self setBtnImage:@"unselected_square" selectedImage:@"selected_square" viewTag:130];
    [self setBtnActionWithTag:130];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)cellBtnClick:(UIButton *)sender{
    [super cellBtnClick:sender];
    if (sender.tag == 100 || sender.tag == 110 || sender.tag == 120 || sender.tag == 130) {
        [sender setSelected:!sender.selected];
    }
    if (sender.tag == 3) {
        //订阅光口选择
    }
}


-(void)setDataToCellView:(BD_IECGooseSubscriptionSCLDataModel *)cellData{
    //tag根据UI设计，从左到右1--10 选择框tag为100---130
    [self viewTagToTF:1].text = cellData.targeMACAddress;
    [self viewTagToTF:2].text = cellData.APPID;
    [[self viewTagToBtn:3] setTitle:cellData.SubscriptionOpticalport forState:UIControlStateNormal];
    [self viewTagToTF:4].text = cellData.describe;
    [self viewTagToTF:5].text = cellData.passageNum;
    [self viewTagToTF:6].text = cellData.version;
    [self viewTagToTF:7].text = cellData.gocbRef;
    [self viewTagToTF:8].text = cellData.datSet;
    [self viewTagToTF:9].text = cellData.goId;
    [self viewTagToTF:10].text = cellData.alowExistTime;
    
    [[self viewTagToBtn:100] setSelected:cellData.isTransmit];
    [[self viewTagToBtn:110] setSelected:cellData.isTest];
    [[self viewTagToBtn:120] setSelected:cellData.ndsCom];
    [[self viewTagToBtn:130] setSelected:cellData.isAnalysis];
}


@end
