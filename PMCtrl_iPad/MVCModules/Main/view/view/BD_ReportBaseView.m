//
//  BD_ReportBaseView.m
//  PMCtrl_iPad
//
//  Created by 张姝枫 on 2018/5/18.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_ReportBaseView.h"
#import "BD_ReprotFormView.h"
#import "UILabel+Extension.h"
#import "BD_ReportBaseModel.h"
#import "BD_FormTBViewBaseModel.h"
@interface BD_ReportBaseView()
@property(nonatomic,weak)UILabel *subTitle;
@property(nonatomic,weak)UILabel *testResult;
@property(nonatomic,weak)BD_ReprotFormView *formView;
//表示报告试图中的图片
@property(nonatomic,weak)UIImageView *imageView;
//评估结果
@property(nonatomic,weak)UILabel *assessmentLabel;


@end

@implementation BD_ReportBaseView
-(instancetype)initWithFrame:(CGRect)frame viewData:(BD_ReportBaseModel *)viewData isShowImageView:(BOOL)isShowImage{
    if (self = [super initWithFrame:frame]) {
        self.viewModel = viewData;
        self.isShowImageView = isShowImage;
        [self loadSubViews];
        [self setViewDatas];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    WeakSelf;
    [self.subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(40);
        make.right.mas_equalTo(-10);
    }];
    [self.testResult mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(weakself.subTitle.mas_bottom).offset(10);
        make.height.mas_equalTo(120);
        make.right.mas_equalTo(-10);
    }];
    [self.formView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(weakself.testResult.mas_bottom).offset(10);
        make.height.mas_equalTo((weakself.viewModel.formDataSource.count+1)*40);
        make.right.mas_equalTo(-10);
    }];
    if (_isShowImageView) {
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(weakself.formView.mas_bottom).offset(10);
            make.height.mas_equalTo(SCREEN_HEIGHT/2);
            make.right.mas_equalTo(-10);
        }];
        
    } else {
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(weakself.formView.mas_bottom).offset(10);
            make.height.mas_equalTo(0);
            make.right.mas_equalTo(-10);
        }];
        
    }
    [self.assessmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(weakself.imageView.mas_bottom).offset(10);
        make.height.mas_equalTo(50);
        make.right.mas_equalTo(-10);
    }];
}

-(BD_ReportBaseModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[BD_ReportBaseModel alloc]init];
    }
    return _viewModel;
}
-(void)loadSubViews{
    if (!self.subTitle) {
        UILabel *subTitle =  [UILabel labelWithText:@"" textColor:Black fontSize:20 alignment:NSTextAlignmentLeft sizeToFit:YES];
        subTitle.font = [UIFont fontWithName:@ "Helvetica-Bold"  size:(20.0)];
        self.subTitle = subTitle;
        [self addSubview:subTitle];
    }
    
    if (!self.testResult) {
        UILabel *testResult =  [UILabel labelWithText:@"" textColor:Black fontSize:15 alignment:NSTextAlignmentLeft sizeToFit:YES];
        testResult.numberOfLines = 0;
        testResult.adjustsFontSizeToFitWidth = YES;
        self.testResult = testResult;
        [self addSubview:testResult];
    }
    if (!self.formView) {
        NSMutableArray *arr_k= [[NSMutableArray alloc]init];
        
        //    [self.viewModel.formDataSource enumerateObjectsUsingBlock:^(NSArray<NSArray<NSDictionary *> *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //        for (NSInteger n = 0; n<obj.count; n++) {
        //            [arr_k addObject:[obj[n][0] allKeys][0]];
        //        }
        //    }];
        if (self.viewModel.formDataSource.count!=0) {
            for (NSInteger n = 0; n<self.viewModel.formDataSource[0].count; n++) {
                [arr_k addObject:[self.viewModel.formDataSource[0][n] allKeys][0]];
            }
        }
        
        BD_ReprotFormView *formView = [[BD_ReprotFormView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain headerTitles:@[[arr_k copy]]];
        
        [formView setCorenerRadius:0 borderColor:Black borderWidth:1.0];
        [self addSubview:formView];
        self.formView = formView;
        
    }
    if (!self.imageView) {
        UIImageView *image = [[UIImageView alloc]init];
        self.imageView = image;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:image];
    }
   
    if (!self.assessmentLabel) {
        UILabel *assessment =  [UILabel labelWithText:@"" textColor:Black fontSize:15 alignment:NSTextAlignmentLeft sizeToFit:YES];
        assessment.numberOfLines = 0;
        assessment.adjustsFontSizeToFitWidth = YES;
        self.assessmentLabel = assessment;
        [self addSubview:assessment];
    }
    
    
}
-(void)setViewDatas{
    self.subTitle.text = self.viewModel.subTitle;
    self.testResult.text = self.viewModel.testResult;
    WeakSelf;
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    [self.viewModel.formDataSource enumerateObjectsUsingBlock:^(NSArray<NSDictionary *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BD_FormTBViewBaseModel *model = [[BD_FormTBViewBaseModel alloc]initWithNum:(int)weakself.viewModel.formDataSource.count];
        
        NSMutableArray *values = [[NSMutableArray alloc]init];
        
        for (NSInteger n = 0; n<obj.count; n++) {
            [values addObject:[obj[n] allValues][0]];
        }
        model.modelDatas = [values copy];
        [arr addObject:model];
    }];
    self.formView.formDatasource = @[[arr copy]];
    [self.formView reloadData];
    self.imageView.image = self.viewModel.image;
    self.assessmentLabel.text = self.viewModel.assessmentResult;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
