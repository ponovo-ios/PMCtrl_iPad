//
//  BD_QuickTestBinaryStateLineViewCell.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/30.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "BD_BinaryStateModel.h"
//#import "BD_BinaryStateLineView.h"
#import "PMCtrl_iPad-Swift.h"
#import "PMCtrl_iPad-Bridging-Header.h"

@interface BD_QuickTestBinaryStateLineViewCell : UITableViewCell
//@property(nonatomic,strong)NSMutableArray<BD_BinaryStateViewModel *> *binaryLineModels;
//@property(nonatomic,strong)NSArray *xvalues;
//@property(nonatomic,strong)BD_BinaryStateLineView *binaryView;
//-(void)setLineData:(NSMutableArray<BD_BinaryStateViewModel *> *)data;
@property(nonatomic,strong)NSArray<NSMutableArray *> *binaryStateValues;
@property(nonatomic,assign)NSInteger xvalue_max;
@end

