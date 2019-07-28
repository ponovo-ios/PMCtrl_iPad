//
//  BD_DifferTestItemListCell.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/11.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BD_DifferTestItemListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *testItemNum;
@property (weak, nonatomic) IBOutlet UILabel *testItemName;
@property (weak, nonatomic) IBOutlet UIButton *testItemIsSelect;
@property (weak, nonatomic) IBOutlet UILabel *testItemResult;

@property(nonatomic,assign)NSInteger cellIndex;
@property(nonatomic,strong)void(^isSelectedItemBlock)(NSInteger cellIndex,BOOL state);
-(void)setSeleState;
@end
