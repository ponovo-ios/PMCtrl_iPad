//
//  StatusSequenceCell.h
//  PMCtrl_iOS
//
//  Created by 杨博宇 on 2017/6/19.
//  Copyright © 2017年 bodian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatusSequenceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *testNum;

@property (weak, nonatomic) IBOutlet UILabel *testName;
@property (weak, nonatomic) IBOutlet UILabel *testProject;
@property (weak, nonatomic) IBOutlet UIButton *isSelect;
@property (weak, nonatomic) IBOutlet UILabel *testResult;

@property(nonatomic,assign)NSInteger cellIndex;
@property(nonatomic,strong)void(^isSelectedItemBlock)(NSInteger cellIndex,BOOL state);
@end
