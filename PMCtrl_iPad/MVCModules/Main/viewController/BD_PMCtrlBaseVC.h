//
//  BD_PMCtrlBaseVC.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/9.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BD_BinarySwitchSetVC.h"
#import "BD_BinaryInSetVC.h"
#import "BD_UtcTime.h"

@class BD_BinarySwitchView;
@class BD_ReportPDFMainVC;
@class BD_DirectCurrentSetManager;
@class BD_RunLightAnimationManager;

@interface BD_PMCtrlBaseVC : UIViewController

/**视图view */
@property(nonatomic,strong)UIScrollView *mainView;
/**底部指示灯*/
@property(nonatomic,strong)BD_BinarySwitchView *switchView;
/**顶部视图按钮scrollView*/
@property(nonatomic,weak)UIScrollView *topTestView;
/**右侧显示测试结果的view*/
@property(nonatomic,strong)UIScrollView *rightResultView;
/**开始
 选中后，按钮不可用isselected = yes userInteraction = no
 未选中，按钮可用 isselected = no userInteration = yes
 */
@property(nonatomic,weak)UIButton *startBtn;
/**停止*/
@property(nonatomic,weak)UIButton *stopBtn;
@property(nonatomic,weak)UIButton *fileManagerBtn;
/**导航栏功能按钮*/
@property(nonatomic,strong)NSArray *naviBtnArr;
/**视图功能按钮*/
@property(nonatomic,strong)NSArray<UIButton *> *viewsBtnArr;

/**开关量设置*/
@property(nonatomic,strong)BD_BinarySwitchSetVC *binarySwitchSetView;
/**开入量设置*/
@property(nonatomic,strong)BD_BinaryInSetVC *binaryInSetView;
/**仪器gps时间*/
@property(nonatomic,strong)BD_UtcTime *gpsTime;
/**报告页面*/
@property(nonatomic,strong)BD_ReportPDFMainVC *reportView;
///**报告视图*/
//@property(nonatomic,strong)BD_ReportMainVC *reportVC;
//直流输出控制器
@property(nonatomic,strong)BD_DirectCurrentSetManager *dcManager;
//run灯动画管理
@property(nonatomic,strong)BD_RunLightAnimationManager *runMangaer;
-(void)configureUI;
-(void)configNavi;
-(void)navigationViewActionWithtag:(NSInteger )tag;
/**开始方法*/
-(void)startAction;
/**停止*/
-(void)stopAction;
/**开入量指示灯状态*/
-(void)updateBinaryStateDatas:(int)binaryAll;
/**开出量指示灯状态*/
-(void)updatebinaryOutState:(int)binaryValue;
/**指示灯恢复默认状态*/
-(void)setLightDefault;
/**根据开关量设置按钮是否可用*/
-(void)setBinaryViewUsed;
/**保存模版文件，显示模版文件名称输入框*/
-(void)templateFileNameEditAlert:(void(^)(NSString *))complete;
/**打开模版文件，显示沙盒中所有模版文件，进行选择*/
-(void)showTemplateFileListView:(UIView *)sourceView complete:(void(^)(NSString *))complete;
/**弹出框的形式打开模版文件*/
-(void)showFileListView:(NSString *)message complete:(void(^)(NSString *))complete;
/**结束试验并创建报告*/
-(void)endTestAndCreateReport;
/**创建报告*/
-(void)createReportVC;
/**文件管理*/
-(void)fileManagerListShow;
@end
