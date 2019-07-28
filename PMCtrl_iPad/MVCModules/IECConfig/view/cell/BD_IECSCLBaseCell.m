//
//  BD_IECSCLBaseCell.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/11.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_IECSCLBaseCell.h"

@implementation BD_IECSCLBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = ClearColor;
    self.contentView.backgroundColor = FormBgColor;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(UIView *)getViewFromTag:(NSInteger)tag{
    return [self viewWithTag:tag];
}


-(void)setBtnImage:(NSString *)NoramlimageName selectedImage:(NSString *)selectedImageName viewTag:(NSInteger)viewTag{
    [((UIButton *) [self getViewFromTag:viewTag]) setImage:[UIImage imageNamed:NoramlimageName] forState:UIControlStateNormal];
    [((UIButton *) [self getViewFromTag:viewTag]) setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
}

-(void)setBtnActionWithTag:(NSInteger)btntag{
    [((UIButton *) [self getViewFromTag:btntag]) addTarget:self action:@selector(cellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}


-(UITextField *)viewTagToTF:(NSInteger)viewTag{
    return (UITextField *)[self getViewFromTag:viewTag];
}

-(UIButton *)viewTagToBtn:(NSInteger )viewTag{
    return (UIButton *)[self getViewFromTag:viewTag];
}
-(UILabel *)viewTagToLabel:(NSInteger)viewTag{
    return (UILabel *)[self getViewFromTag:viewTag];
}
//cell 中 button的事件，统一使用
-(void)cellBtnClick:(UIButton *)sender{
   
}

@end
