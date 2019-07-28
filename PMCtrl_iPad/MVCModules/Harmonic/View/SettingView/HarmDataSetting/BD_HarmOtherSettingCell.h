//
//  BD_HarmOtherSettingCell.h
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/11/30.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BD_HarmOtherSettingCellDelegate <NSObject>

/**
 点击 全选按钮 或 全不选按钮

 @param isSelect YES为全选  NO为全不选
 */
-(void)didSelectAllCell:(BOOL)isSelect;

-(void)changeValue:(NSInteger)tag;

@end

@interface BD_HarmOtherSettingCell : UITableViewCell

/**代理*/
@property (nonatomic, weak) id<BD_HarmOtherSettingCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *subtractionBtn;

@end
