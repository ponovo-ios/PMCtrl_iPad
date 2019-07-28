//
//  BD_HarmDCCell.h
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/11/30.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BD_HarmDCCellDelegate<NSObject>

-(void)changeCellIndex:(NSInteger)index textField:(UITextField *)textField;

@end

@interface BD_HarmDCCell : UITableViewCell

/**代理*/
@property (nonatomic, weak) id<BD_HarmDCCellDelegate> delegate;

/**index*/
@property (nonatomic, assign) NSInteger index;
/**分割线*/
@property (nonatomic, weak) UIView *lineView;
/**标题1*/
@property (nonatomic, weak) UILabel *firstTitle;
/**标题2*/
@property (nonatomic, weak) UILabel *secondTitle;
/**按钮1*/
@property (nonatomic, weak) UITextField *firstTF;
/**按钮2*/
@property (nonatomic, weak) UITextField *secondTF;
@end
