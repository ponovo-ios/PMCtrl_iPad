//
//  BD_QuickTestBLVView.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/17.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BD_QuickTestBLVView : UIView
@property (weak, nonatomic) IBOutlet UIButton *blvBtn;
@property (weak, nonatomic) IBOutlet UILabel *blvLabel;
@property (weak, nonatomic) IBOutlet UIView *blvColorView;
@property (nonatomic,assign)int viewtag;
@property (nonatomic,strong)void (^blvSelectedBlock)(int,BOOL);
-(void)setData:(BOOL)state title:(NSString *)title lineColor:(UIColor *)lineColor;

@end
