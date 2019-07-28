//
//  BD_SMVBaseVC.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/1/3.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_SMVBaseVC.h"

@interface BD_SMVBaseVC (){
    
}

@end

@implementation BD_SMVBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO ;
    _selectedCellIndex = 0;
    [self confitViews];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    //设置默认选中第一行，必须在viewwillAppear中写
    [super viewWillAppear:animated];
    NSIndexPath * selIndex = [NSIndexPath indexPathForRow:_selectedCellIndex inSection:0];
    [_topTableView selectRowAtIndexPath:selIndex animated:YES scrollPosition:UITableViewScrollPositionTop];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)confitViews{
    //添加页面views，约束
}



//触碰view后隐藏键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
