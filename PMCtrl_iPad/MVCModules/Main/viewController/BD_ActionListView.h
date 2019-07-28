//
//  BD_ActionListView.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/11.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BD_ActionListView : UIView
@property(nonatomic,strong)NSArray *actionBtns;

@property(nonatomic,strong)void(^actionIndexBlock)(NSInteger index);

-(instancetype)initWithTitles:(NSArray *)titles;

@end
