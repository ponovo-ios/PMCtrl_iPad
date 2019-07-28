//
//  BD_QuickTestVectorgraphView.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/17.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BD_QuickTestVactorgraphModel.h"
@interface BD_QuickTestVectorgraphView : UIView
@property (nonatomic, copy) BD_QuickTestVactorgraphModel * viewData;
@property (nonatomic,strong)NSMutableDictionary *drawLineDic;
@property (nonatomic,strong)NSArray<NSString *> *lineTitleArr;
@end
