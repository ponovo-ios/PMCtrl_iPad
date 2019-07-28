//
//  BD_HarmDataSettingCell.h
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/11/30.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BD_HarmDataSettingCellDelegate <NSObject>

-(void)changeValue:(NSInteger)tag text:(NSString *)text;

@end

@interface BD_HarmDataSettingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *amplitudeTF;
@property (weak, nonatomic) IBOutlet UITextField *containingRateTF;
@property (weak, nonatomic) IBOutlet UITextField *phaseTF;


/**代理*/
@property (nonatomic, weak) id<BD_HarmDataSettingCellDelegate> delegate;
/**修改单位*/
-(void)changePassageWay:(NSString *)passageWay;
@end
