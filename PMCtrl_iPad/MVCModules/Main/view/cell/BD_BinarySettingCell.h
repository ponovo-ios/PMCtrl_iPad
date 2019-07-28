//
//  BD_BinarySettingCell.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/2/9.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BD_BinarySettingCell : UITableViewCell

@property(nonatomic,assign)int cellIndex;
@property(nonatomic,strong)void(^selectedBlankNodeBlock)(int,bool);

@property(nonatomic,strong)void(^rolloverValueBlock)(int,NSString *);
@end
