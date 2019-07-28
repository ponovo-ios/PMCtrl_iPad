//
//  BD_VactorgraphViewDataCell.h
//  PMCtrl_iPad
//
//  Created by 张姝枫 on 2018/6/5.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BD_VactorgraphViewDataCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UIView *lineMarkColorView;

@property (weak, nonatomic) IBOutlet UILabel *amplitudeValue;
@property (weak, nonatomic) IBOutlet UILabel *phaseValue;
@property (weak, nonatomic) IBOutlet UILabel *frequencyValue;

@property (weak, nonatomic) IBOutlet UILabel *amplitudeLabel;


@property(nonatomic,assign)int cellIndex;
@property(nonatomic,copy)void(^selectedBlock)(BOOL,int);

@end
