//
//  BD_SMVWeaksignalOutputCell1.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/7.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BD_SMVWeaksignalChangePassagewayMapDelegate<NSObject>
@optional

@required
-(void)changepassageWayMap1:(NSInteger)index sourceView:(UIButton *)sourceView;
-(void)changepassageWayMap2:(NSInteger)index sourceView:(UIButton *)sourceView;
@end

/**横排两个下拉列表，可点击*/
@interface BD_SMVWeaksignalOutputCell1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *passagewayNumLabel1;
@property (weak, nonatomic) IBOutlet UILabel *passagewayNumLabel2;
@property (weak, nonatomic) IBOutlet UIButton *passagewayMap1;
@property (weak, nonatomic) IBOutlet UIButton *passagewayMap2;
@property(nonatomic,assign)NSInteger cellIndex;
@property(nonatomic,weak)id<BD_SMVWeaksignalChangePassagewayMapDelegate> cell1delegate;
@end
