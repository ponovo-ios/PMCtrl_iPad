//
//  BD_HarmPassagewaySelCell.m
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/11/30.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_HarmPassagewaySelCell.h"
#import "BD_HarmDataSettingModel.h"
#import "BD_PopListViewManager.h"
@interface BD_HarmPassagewaySelCell()


@end

@implementation BD_HarmPassagewaySelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_firstPickerBtn setCorenerRadius:6 borderColor:White borderWidth:1.0];
    [_secondPickerBtn setCorenerRadius:6 borderColor:White borderWidth:1.0];
    _firstPickerBtn.backgroundColor = BDThemeColor;
    _secondPickerBtn.backgroundColor = BDThemeColor;
    // Initialization code
}

- (IBAction)firstPickerBtnClick:(BD_PickerButton *)sender {
    __weak typeof(self) weakSelf = self;
//    [sender showPickerViewWithDataArray:self.paramsArray completion:^(NSString *title) {
//        weakSelf.dataModel.channelPort = title;
//    }];
    
    
    [BD_PopListViewManager ShowPopViewWithlistDataSource:self.paramsArray textField:sender viewController:[self GetSubordinateControllerForSelf]direction:UIPopoverArrowDirectionUp complete:^(NSString *title) {
        weakSelf.dataModel.channelPort = title;
        [weakSelf.firstPickerBtn setTitle:title forState:UIControlStateNormal];
        weakSelf.changePassageBlock();
    }];
}

- (IBAction)secondPickerBtnClick:(BD_PickerButton *)sender {
    __weak typeof(self) weakSelf = self;
//    [sender showPickerViewWithDataArray:self.passagewayArray completion:^(NSString *title) {
//        DLog(@"%@", sender.titleLabel.text);
//        weakSelf.dataModel.passagewayIndex = title;
//    }];
 
    NSMutableArray *passarr = [self sortHarmNum:self.passagewayArray];
    NSMutableArray *passnew = [[NSMutableArray alloc]init];
    [passarr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isEqualToString:@"基波"]) {
             [passnew addObject:[NSString stringWithFormat:@"%@",obj]];
        }
    }];
    [BD_PopListViewManager ShowPopViewWithlistDataSource:passnew textField:sender viewController:[self GetSubordinateControllerForSelf]direction:UIPopoverArrowDirectionUp complete:^(NSString *title) {
        weakSelf.dataModel.passagewayIndex = [title stringByReplacingOccurrencesOfString:@"次谐波" withString:@""];
        [weakSelf.secondPickerBtn setTitle:title forState:UIControlStateNormal];
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(NSMutableArray *)sortHarmNum:(NSMutableArray *)historyArr{
    for (int i = 1; i<historyArr.count; i++) {
        for (int j = 1; j<historyArr.count-1; j++) {
            if ([historyArr[j] floatValue]>[historyArr[j+1] floatValue]) {
                [historyArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    return historyArr;
}
@end
