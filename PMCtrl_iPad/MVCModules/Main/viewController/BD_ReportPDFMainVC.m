//
//  BD_ReportPDFMainVC.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/5/17.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_ReportPDFMainVC.h"
#import <QuickLook/QuickLook.h>

@interface BD_ReportPDFMainVC ()<QLPreviewControllerDataSource>
@property (strong, nonatomic)QLPreviewController *previewController;
@property (copy, nonatomic)NSURL *fileURL; //文件路径
@end

@implementation BD_ReportPDFMainVC

-(instancetype)init{
    if (self = [super init]) {
       
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    UIButton *closeBtn = [[UIButton alloc]init];
    closeBtn.frame = CGRectMake(self.view.width-80,10,50, 35.0);
    [closeBtn setTintColor:[UIColor blueColor]];
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    
    self.previewController  =  [[QLPreviewController alloc]  init];
    self.previewController.dataSource  = self;
    [self.view addSubview:self.previewController.view];
    self.previewController.view.frame = CGRectMake(0,closeBtn.bottom, self.view.width, self.view.height-closeBtn.bottom);
    //刷新界面,如果不刷新的话，不重新走一遍代理方法，返回的url还是上一次的url
    [self.previewController refreshCurrentPreviewItem];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - QLPreviewControllerDataSource
-(id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    self.fileURL = [documentsDirectoryURL URLByAppendingPathComponent:_fileName];
    return self.fileURL;
}

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)previewController{
    return 1;
}
-(void)refreshView{
     [self.previewController refreshCurrentPreviewItem];
}
-(void)closeView:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
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
