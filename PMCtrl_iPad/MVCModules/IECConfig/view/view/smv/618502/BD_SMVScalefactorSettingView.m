//
//  BD_SMVScalefactorSettingView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/13.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_SMVScalefactorSettingView.h"
#import "BD_SMVScalefactorSetCell.h"
#import "UITextField+Extension.h"
#import "UIButton+Extension.h"
#import "BD_SMV618502DetailSetInterchangerQualityVC.h"
@interface BD_SMVScalefactorSettingView()<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *tableIView;
@property (weak, nonatomic) IBOutlet UITextField *interchangerDelayTimeTF;
@property (weak, nonatomic) IBOutlet UIButton *interchangerQualityBtn;
@property (nonatomic,strong)BD_SMV618502DetailSetInterchangerQualityDataModel *interchangeQualityVC;
@end

@implementation BD_SMVScalefactorSettingView
-(void)awakeFromNib{
    [super awakeFromNib];
    _tableIView.delegate = self;
    _tableIView.dataSource = self;
    self.backgroundColor = ClearColor;
    _tableIView.backgroundColor = ClearColor;
    _tableIView.scrollEnabled = NO;
    [_tableIView registerNib:[UINib nibWithNibName:@"BD_SMVScalefactorSetCell" bundle:nil] forCellReuseIdentifier:@"BD_SMVScalefactorSetCellID"];
    [_interchangerDelayTimeTF setDefaultSetting];
    [_interchangerQualityBtn setCorenerRadius:6 borderColor:White borderWidth:1];
    [_interchangerQualityBtn setTitle:@"0x00" forState:UIControlStateNormal];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BD_SMVScalefactorSetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BD_SMVScalefactorSetCellID" forIndexPath:indexPath];
    cell.title.text = @[@"Uabcz",@"Uabcz'",@"Usabcz",@"Utabcz"][indexPath.row];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = self.backgroundColor;
    
    UILabel *titleLabel1 = [[UILabel alloc] init];
    titleLabel1.textAlignment = NSTextAlignmentCenter;
    titleLabel1.textColor = [UIColor whiteColor];
    titleLabel1.font = [UIFont systemFontOfSize:13];
    titleLabel1.text = @"电流比例因子";
    
    [headerView addSubview:titleLabel1];
    
    [titleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(70);
    }];
    
    UILabel *titleLabel2 = [[UILabel alloc] init];
    
    titleLabel2.textColor = [UIColor whiteColor];
    titleLabel2.text = @"电压比例因子";
    titleLabel2.textAlignment = NSTextAlignmentCenter;
    titleLabel2.font = [UIFont systemFontOfSize:13];
    [headerView addSubview:titleLabel2];
    
    [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-10);
        make.left.mas_equalTo(titleLabel1.mas_right).offset(10);
        make.width.mas_equalTo(titleLabel1);
    }];
    
    
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (IBAction)interchangerQualityAction:(id)sender {
    
    [self popInterchangeQualityViewToWindow:(UIButton *)sender];
}



-(void)popInterchangeQualityViewToWindow:(UIView *)sourceView{
    BD_SMV618502DetailSetInterchangerQualityVC *pop = [[BD_SMV618502DetailSetInterchangerQualityVC alloc]init];
    [pop.view setFrame:CGRectMake(0, 0, 300, 300)];
    pop.modalPresentationStyle = UIModalPresentationPopover;
    pop.preferredContentSize = CGSizeMake(350, 240);
    UIPopoverPresentationController *popPresenter = pop.popoverPresentationController;
    popPresenter.sourceView = sourceView;
    popPresenter.sourceRect = sourceView.bounds;
    popPresenter.permittedArrowDirections = UIPopoverArrowDirectionLeft; 
    [[self GetSubordinateControllerForSelf] presentViewController:pop animated:NO completion:nil];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
