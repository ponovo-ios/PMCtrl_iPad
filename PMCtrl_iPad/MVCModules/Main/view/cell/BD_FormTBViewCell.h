//
//  BD_FormTBViewCell.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/21.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BD_FormTBViewCell : UITableViewCell
@property(nonatomic,strong)NSArray<UILabel *> *formArr;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier num:(int)num;
@end
