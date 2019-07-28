//
//  BD_GooseTransmitSCLFormCell.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/5.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_GooseTransmitSCLFormCell.h"
#import "UITextField+Extension.h"
@interface BD_GooseTransmitSCLFormCell()
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
    [self setBtnImage:@"selected_square" selectedImage:@"unselected_square" viewTag:100];
    [self setBtnActionWithTag:100];
    //测试
    [self setBtnImage:@"selected_square" selectedImage:@"unselected_square" viewTag:110];
    [self setBtnActionWithTag:110];
    //ndsCom
    [self setBtnImage:@"selected_square" selectedImage:@"unselected_square" viewTag:120];
    [self setBtnActionWithTag:120];
    
    
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


//根据view tag 获取页面上的view，设置按钮image
-(void)setBtnImage:(NSString *)NoramlimageName selectedImage:(NSString *)selectedImageName viewTag:(NSInteger)viewTag{
    [((UIButton *) [self getViewFromTag:viewTag]) setImage:[UIImage imageNamed:NoramlimageName] forState:UIControlStateNormal];
    [((UIButton *) [self getViewFromTag:viewTag]) setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
}
//根据view tag 获取页面上的view，设置button的事件
-(void)setBtnActionWithTag:(NSInteger)btntag{
    [((UIButton *) [self getViewFromTag:btntag]) addTarget:self action:@selector(cellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}


//cell 中 button的事件，统一使用
-(void)cellBtnClick:(UIButton *)sender{
    if (sender.tag == 100 || sender.tag == 110 || sender.tag == 120) {
        [sender setSelected:!sender.selected];
    }
    if (sender.tag == 6) {
        //输出光口选择
    }
    
}
@end
