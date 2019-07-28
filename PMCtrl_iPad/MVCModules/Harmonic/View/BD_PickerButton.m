//
//  BD_PickerButton.m
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/11/30.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_PickerButton.h"
#import "UIView+Extension.h"

@interface BD_PickerButton()<UIPickerViewDelegate,UIPickerViewDataSource>
/**dataArray*/
@property (nonatomic, copy) NSArray *dataArray;

/**<#Description#>*/
@property (nonatomic, copy) void(^completion)(NSString *title) ;

@end

@implementation BD_PickerButton

-(void)awakeFromNib
{
    [super awakeFromNib];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

-(void)showPickerViewWithDataArray:(NSArray<NSString *> *)dataArray completion:(void (^)(NSString *title))completion
{
    self.dataArray = dataArray;
    if (dataArray.count < 3) {
        __weak typeof(self) weakSelf = self;
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        for (NSInteger i = 0; i < dataArray.count; i++) {
            UIAlertAction *PointAction = [UIAlertAction actionWithTitle:dataArray[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf setTitle:dataArray[i] forState:UIControlStateNormal];
                completion(dataArray[i]);
            }];
            [alertController addAction:PointAction];
        }
        alertController.modalPresentationStyle = UIModalPresentationPopover;
        
        UIPopoverPresentationController *popPresenter = alertController.popoverPresentationController;
        popPresenter.sourceView = self;
        popPresenter.sourceRect = self.bounds;
        popPresenter.permittedArrowDirections = UIPopoverArrowDirectionUp;
        
        //  弹出
        [[self GetSubordinateControllerForSelf] presentViewController:alertController animated:YES completion:nil];
        
    }else{
        
        self.completion = completion;
        
        UIViewController *pickerVC = [[UIViewController alloc] init];
        UIPickerView *picker = [[UIPickerView alloc] init];
        picker.backgroundColor = [UIColor groupTableViewBackgroundColor];
        picker.delegate = self;
        picker.dataSource = self;
        [pickerVC.view addSubview:picker];
        [picker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.equalTo(pickerVC.view);
        }];
        
        if ([dataArray containsObject:self.titleLabel.text]) {
            [picker selectRow:[dataArray indexOfObject:self.titleLabel.text] inComponent:0 animated:NO];
        }else{
            [picker selectRow:0 inComponent:0 animated:NO];
            [self setTitle:dataArray.firstObject forState:UIControlStateNormal];
        }
        
        pickerVC.modalPresentationStyle = UIModalPresentationPopover;
        pickerVC.preferredContentSize = CGSizeMake(200, 100);
        UIPopoverPresentationController *popPresenter = pickerVC.popoverPresentationController;
        popPresenter.sourceView = self;
        popPresenter.sourceRect = self.bounds;
        popPresenter.permittedArrowDirections = UIPopoverArrowDirectionUp; //设置弹出方向
        [[self GetSubordinateControllerForSelf] presentViewController:pickerVC animated:NO completion:nil];
    }
}

#pragma mark
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.dataArray[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    [self setTitle:self.dataArray[row] forState:UIControlStateNormal];
    
    self.completion(self.dataArray[row]);
  
   
}


@end
