//
//  BD_IECSCLBaseCell.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/11.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BD_IECSCLBaseCell : UITableViewCell
-(UIView *)getViewFromTag:(NSInteger)tag;
//根据view tag 获取页面上的view，设置按钮image
-(void)setBtnImage:(NSString *)NoramlimageName selectedImage:(NSString *)selectedImageName viewTag:(NSInteger)viewTag;
//根据view tag 获取页面上的view，设置button的事件
-(void)setBtnActionWithTag:(NSInteger)btntag;

//cell 中 button的事件，统一使用
-(void)cellBtnClick:(UIButton *)sender;
/**tag返回textfield*/
-(UITextField *)viewTagToTF:(NSInteger)viewTag;
/**tag返回UIButton*/
-(UIButton *)viewTagToBtn:(NSInteger )viewTag;
/**tag返回label*/
-(UILabel *)viewTagToLabel:(NSInteger)viewTag;
@end
