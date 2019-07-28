//
//  BD_DirecCurrentCell.h
//  PMCtrl_iPad
//
//  Created by 张姝枫 on 2018/2/11.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BD_DirectCurrentoutputActionDelegate

@required
-(void)startOutput;
-(void)stopOutput;
@end



@interface BD_DirecCurrentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *DCTitle;
@property (weak, nonatomic) IBOutlet UITextField *DCTextField;
@property (weak, nonatomic) IBOutlet UIButton *DCStartOutBtn;
@property (weak, nonatomic) IBOutlet UIButton *DCStopOutBtn;

@property(nonatomic,strong)id<BD_DirectCurrentoutputActionDelegate>delegate;

@end
