//
//  BD_SMVScalefactorSetCell.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/13.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BD_SMVScalefactorSetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UITextField *currentScalefactorTF;
@property (weak, nonatomic) IBOutlet UITextField *voltageScalefactorTF;

@end
