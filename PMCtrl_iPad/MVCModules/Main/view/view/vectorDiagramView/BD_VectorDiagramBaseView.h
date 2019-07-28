//
//  BD_VectorDiagramBaseView.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/12.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BD_TestDataParamModel;
@class BD_VectorMaxValueModel;
@interface BD_VectorDiagramBaseView : UIView
@property(nonatomic,strong)NSArray<BD_TestDataParamModel *> *formDataSource;
@property(nonatomic,strong)NSArray<NSString *> *headerViewTitles;
@property(nonatomic,strong)BD_VectorMaxValueModel * MAXAmplitudeModel;
-(void)reloadTBView;
@end
