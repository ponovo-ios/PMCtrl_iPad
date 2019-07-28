//
//  BD_SMVWeakSignalMapBaseView.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/12.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
/** smv分页 详细设置 弱信号映射view*/
@interface BD_SMVDetailSettingWeakSignalMapBaseView : UIView
@property (weak, nonatomic) IBOutlet UIButton *weakSignalBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *PTChangeTF1;
@property (weak, nonatomic) IBOutlet UITextField *PTChangeTF2;
@property (weak, nonatomic) IBOutlet UITextField *CTChangeTF1;
@property (weak, nonatomic) IBOutlet UITextField *CTChangeTF2;
@property (weak, nonatomic) IBOutlet UILabel *PTChangeTitle;
@property (weak, nonatomic) IBOutlet UILabel *CTChangeTitle;

@end
