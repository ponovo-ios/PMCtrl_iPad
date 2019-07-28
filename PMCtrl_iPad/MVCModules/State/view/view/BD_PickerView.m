//
//  BD_PickerView.m
//  PMCtrl_iPad
//
//  Created by 张姝枫 on 2018/1/7.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_PickerView.h"
@interface BD_PickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
@end

@implementation BD_PickerView

-(instancetype)init{
    if (self = [super init]) {
        [self createPicker];
    }
    return self;
}
#pragma mark - 懒加载
-(NSArray *)hours{
    if (!_hours) {
        NSMutableArray *hh = [[NSMutableArray alloc]init];
        for (int i = 0; i<23; i++) {
            [hh addObject:[NSString stringWithFormat:@"%2dz",i]];
        }
        _hours = [hh copy];
    }
    return _hours;
}

-(NSArray *)minutes{
    if (!_minutes) {
        NSMutableArray *mm = [[NSMutableArray alloc]init];
        for (int i = 0; i<59; i++) {
            [mm addObject:[NSString stringWithFormat:@"%2dz",i]];
        }
        _minutes = [mm copy];
    }
    return _minutes;
}
-(NSArray *)seconds{
    if (!_seconds) {
        NSMutableArray *ss = [[NSMutableArray alloc]init];
        for (int i = 0; i<59; i++) {
            [ss addObject:[NSString stringWithFormat:@"%2dz",i]];
        }
        _minutes = [ss copy];
    }
    return _seconds;
}

-(void)createPicker{
    _datePickerView = [[UIPickerView alloc]initWithFrame:self.bounds];
    _datePickerView.delegate = self;
    _datePickerView.dataSource = self;
    [self addSubview:_datePickerView];
    
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (component) {
        case 0:
            return self.hours.count;
            break;
        case 1:
            return self.minutes.count;
            break;
        case 2:
            return self.seconds.count;
            break;
        default:
            break;
    }
    return 0;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
