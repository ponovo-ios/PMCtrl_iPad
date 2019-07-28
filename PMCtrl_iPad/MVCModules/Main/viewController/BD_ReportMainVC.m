//
//  BD_ReportMainVC.m
//  PMCtrl_iPad
//
//  Created by 张姝枫 on 2018/5/18.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_ReportMainVC.h"
#import "BD_ReportBaseView.h"
#import "BD_ReportBaseModel.h"
#import "UILabel+Extension.h"
@interface BD_ReportMainVC ()

@property(nonatomic,strong)NSArray<BD_ReportBaseView *> *baseViews;
@property(nonatomic,assign)CGFloat contentSizeH;
@property(nonatomic,weak)UILabel *reportTitle;
@property(nonatomic,weak)UILabel *objectMessNumLabel;
@end

@implementation BD_ReportMainVC

-(instancetype)init{
    self = [super init];
    if (self) {
        
         [self loadSubViews];
        _moduleType = BD_TestModuleType_Manual;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = White;
    self.navigationItem.title = @"试验报告";
    self.navigationController.navigationBar.barTintColor = BtnViewBorderColor;
    //        [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:BtnViewBorderColor}];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:White,NSFontAttributeName:[UIFont boldSystemFontOfSize:18]}];
    
    self.navigationItem.titleView = nil;
    self.navigationController.navigationBar.tintColor = BtnViewBorderColor;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:@"保存报告" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(saveReport) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItems = @[rightItem];
    // Do any additional setup after loading the view.
}
-(void)viewWillLayoutSubviews{
    [super viewDidLayoutSubviews];
    WeakSelf;
    [self.scrollView setFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    [self.reportTitle setFrame:CGRectMake(10, 10, self.view.width-20, 30)];
    [self.objectMessNumLabel setFrame:CGRectMake(10,10+self.reportTitle.bottom, self.view.width-20, 30)];
    self.contentSizeH = 0;
  static  CGFloat lastHeight = 100;
    [self.baseViews enumerateObjectsUsingBlock:^(BD_ReportBaseView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat baseHeight = 0;
        
        if (!obj.isShowImageView) {
            baseHeight = 340+(_reportDatas[idx].formDataSource.count+1)*40;
        } else {
            baseHeight = 340+(_reportDatas[idx].formDataSource.count+1)*40+SCREEN_HEIGHT/2;
        }
        if (idx==0) {
            lastHeight = 100;
        } else {
            lastHeight += weakself.baseViews[idx-1].isShowImageView?340+(_reportDatas[idx-1].formDataSource.count+1)*40+SCREEN_HEIGHT/2+10:340+(_reportDatas[idx-1].formDataSource.count+1)*40+10;
        }
        if (idx == 0) {
            [obj setFrame:CGRectMake(0,lastHeight, weakself.view.width,baseHeight)];
        } else {
            [obj setFrame:CGRectMake(0,lastHeight, weakself.view.width,baseHeight)];
        }
        
        weakself.contentSizeH += baseHeight+10;
        
        
    }];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width,weakself.contentSizeH+100);
}

#pragma mark-懒加载

-(void)loadSubViews{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    self.moduleTestName = @"";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadReportViews{
    
    if (!self.reportTitle) {
        UILabel *title =  [UILabel labelWithText:@"" textColor:Black fontSize:20 alignment:NSTextAlignmentCenter sizeToFit:YES];
        title.font = [UIFont fontWithName:@ "Helvetica-Bold"  size:(20.0)];
        self.reportTitle = title;
        self.reportTitle.text = self.moduleTestName;
        [self.scrollView addSubview:title];
    } else {
        self.reportTitle.text = self.moduleTestName;
    }
   
    if (!self.objectMessNumLabel) {
        UILabel *objectMessNumLabel =  [UILabel labelWithText:@"" textColor:Black fontSize:20 alignment:NSTextAlignmentLeft sizeToFit:YES];
        objectMessNumLabel.font = [UIFont fontWithName:@ "Helvetica-Bold"  size:(20.0)];
        self.objectMessNumLabel = objectMessNumLabel;
        self.objectMessNumLabel.text = self.objectMessageNum;
        [self.scrollView addSubview:objectMessNumLabel];
    } else {
         self.objectMessNumLabel.text = self.objectMessageNum;
    }
    
    if (self.baseViews.count==0) {
        NSMutableArray *baseViewArr = [[NSMutableArray alloc]init];
        for (NSInteger i = 0; i<_reportDatas.count; i++) {
            BD_ReportBaseView *baseView = [[BD_ReportBaseView alloc]initWithFrame:CGRectZero viewData:_reportDatas[i] isShowImageView:_reportDatas[i].isShowImage];
            [self.scrollView addSubview:baseView];
            [baseViewArr addObject:baseView];
        }
        self.baseViews = [baseViewArr copy];
    } else {
        [self.baseViews enumerateObjectsUsingBlock:^(BD_ReportBaseView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.viewModel = _reportDatas[idx];
            [obj setViewDatas];
            
        }];
    }
    
}
-(void)saveReport{
    NSMutableData *pdfData = [[BD_Utils shared] saveToPDFData:self.scrollView];
    NSString *moduleName = @"";
    switch (_moduleType) {
        case BD_TestModuleType_Manual:
            moduleName = @"手动";
            break;
        case BD_TestModuleType_Status:
            moduleName = @"状态序列";
            break;
            
        case BD_TestModuleType_Diff:
            moduleName = @"差动";
            break;
            
        case BD_TestModuleType_Harm:
            moduleName = @"谐波";
            break;
            
        case BD_TestModuleType_Distance:
            moduleName = @"距离";
            break;
            
        case BD_TestModuleType_SearchZBorder:
            moduleName = @"搜索阻抗";
            break;
            
        case BD_TestModuleType_CBOperateTest:
            moduleName = @"整组";
            break;
            
        default:
            break;
    }
    BOOL isSuc = [pdfData writeToFile:[FileUtil createFileWithFileName:[NSString stringWithFormat:@"/%@%@.pdf",moduleName,[BD_Utils getCurrentDateWithFormat:@"yyyy-MM-dd HH:mm:ss"]]] atomically:YES];
    if (isSuc) {
        [MBProgressHUDUtil showMessage:@"报告保存成功" toView:self.view];
     
    } else {
         [MBProgressHUDUtil showMessage:@"报告保存失败" toView:self.view];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
