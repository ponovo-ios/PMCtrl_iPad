//
//  BD_OuptupWaveShapeDataCell.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/28.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BD_OutputWaveShapeDataCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *waveTitle;
@property (weak, nonatomic) IBOutlet UILabel *amplitudeValue;
@property (weak, nonatomic) IBOutlet UILabel *phaseValue;
@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;
@property (weak, nonatomic) IBOutlet UIView *lineMarkColorView;

@property (weak, nonatomic) IBOutlet UILabel *amplitudeLabel;

@property(nonatomic,assign)int cellIndex;
@property(nonatomic,copy)void(^selectedBlock)(BOOL,int);
//添加虚线
-(void)addLayerToMarkViewWithColor:(UIColor *)color title:(NSString *)title;
@end
