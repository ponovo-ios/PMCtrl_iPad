//
//  BD_IECSMVTransmitVC.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/23.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_IECSMVTransmitVC.h"
#import "BD_SMV61850-9-1VC.h"
#import "BD_SMV61850-9-2VC.h"
#import "BD_SMV60044VC.h"
#import "BD_SMVCollectorOutputVC.h"
#import "BD_SMVWeaksignalOutputVC.h"
@interface BD_IECSMVTransmitVC ()<UIScrollViewDelegate>{
    UIView *currentView;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollVIew;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property(nonatomic,strong)NSMutableArray<UIViewController *> *viewControllers;
@end

@implementation BD_IECSMVTransmitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadScrollViews];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillLayoutSubviews{
    
    [_viewControllers[0].view setFrame: CGRectMake(0*_scrollVIew.width, 0, _scrollVIew.width, _scrollVIew.height)];
    [_viewControllers[1].view setFrame: CGRectMake(1*_scrollVIew.width, 0, _scrollVIew.width, _scrollVIew.height)];
    [_viewControllers[2].view setFrame: CGRectMake(2*_scrollVIew.width, 0, _scrollVIew.width, _scrollVIew.height)];
    [_viewControllers[3].view setFrame: CGRectMake(3*_scrollVIew.width, 0, _scrollVIew.width, _scrollVIew.height)];
    [_viewControllers[4].view setFrame: CGRectMake(4*_scrollVIew.width, 0, _scrollVIew.width, _scrollVIew.height)];
    
    
}
-(void)loadScrollViews{
   
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"IECConfig" bundle:nil];
    BD_SMV61850_9_1VC *vc1 = [storyboard instantiateViewControllerWithIdentifier:@"BD_SMV61850_9_1VCID"];
    
    [self.viewControllers addObject:vc1];
    [vc1.view setFrame: CGRectMake(0*_scrollVIew.width, 0, _scrollVIew.width, _scrollVIew.height)];
    [vc1.topTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:vc1.selectedCellIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    
    BD_SMV61850_9_2VC *vc2 = [storyboard instantiateViewControllerWithIdentifier:@"BD_SMV61850_9_2VCID"];
  
    [self.viewControllers addObject:vc2];
     [vc2.view setFrame: CGRectMake(1*_scrollVIew.width, 0, _scrollVIew.width, _scrollVIew.height)];
    [vc2.topTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:vc2.selectedCellIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    BD_SMV60044VC *vc3 = [storyboard instantiateViewControllerWithIdentifier:@"BD_SMV60044VCID"];
   
    
    [self.viewControllers addObject:vc3];
     [vc3.view setFrame: CGRectMake(2*_scrollVIew.width, 0, _scrollVIew.width, _scrollVIew.height)];
    [vc3.topTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:vc3.selectedCellIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    
    
    BD_SMVCollectorOutputVC *vc4 = [storyboard instantiateViewControllerWithIdentifier:@"BD_SMVCollectorOutputVCID"];
   
    [self.viewControllers addObject:vc4];
     [vc4.view setFrame: CGRectMake(3*_scrollVIew.width, 0, _scrollVIew.width, _scrollVIew.height)];
    
    [vc4.topTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:vc4.selectedCellIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    
    BD_SMVWeaksignalOutputVC *vc5 = [storyboard instantiateViewControllerWithIdentifier:@"BD_SMVWeaksignalOutputVCID"];
  
    [self.viewControllers addObject:vc5];
    [vc5.view setFrame: CGRectMake(4*_scrollVIew.width, 0, _scrollVIew.width, _scrollVIew.height)];
    
    [self loadVisiblePages];
    _scrollVIew.showsVerticalScrollIndicator = NO;
    _scrollVIew.showsHorizontalScrollIndicator = NO;
    _scrollVIew.pagingEnabled = YES;
     [_scrollVIew setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    _scrollVIew.delegate = self;
    _scrollVIew.backgroundColor = MainBgColor;
    _scrollVIew.bounces = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载
-(NSMutableArray<UIViewController*> *)viewControllers{
    if (!_viewControllers) {
        _viewControllers  = [[NSMutableArray alloc]init];
    }
    return _viewControllers;
}

- (IBAction)changeSegment:(id)sender {
   
    switch (_segmentControl.selectedSegmentIndex) {
        case 0:
         
            break;
        case 1:
       
            break;
        case 2:
          
            break;
        case 3:
        
            break;
        case 4:
         
            break;
       
        default:
            break;
    }
    _scrollVIew.contentOffset = CGPointMake(_segmentControl.selectedSegmentIndex*_scrollVIew.width, 0);
    [self loadVisiblePages];
}


-(void)loadPage:(NSInteger)page{
    if (page < 0 || page >= _viewControllers.count) {
        // 如果超出了页面显示的范围，什么也不需要做
        return;
    }
    
    CGRect frame = _scrollVIew.frame;
    frame.origin.x = _scrollVIew.width * page;    //此处决定了整个滑动页面的宽度，如果宽度定义不准确，不能合理的显示页面
    frame.origin.y = 0.0;
    
    _viewControllers[page].view.frame = frame;
    currentView = _viewControllers[page].view;
    _scrollVIew.contentSize = CGSizeMake(_scrollVIew.width*_viewControllers.count, _scrollVIew.height);
    [_scrollVIew addSubview:currentView];
    
}


-(void)loadVisiblePages{
    // 首先确定当前可见的页面
    NSInteger pageWidth = _scrollVIew.width;
    NSInteger page = (int)_scrollVIew.contentOffset.x / pageWidth;
    
    // 更新segment
    [self.segmentControl setSelectedSegmentIndex:page];
    [self.pageControl setCurrentPage:page];
    
    // 计算那些页面需要加载
    NSInteger firstPage = page;
    NSInteger lastPage = page + _viewControllers.count;
    
    // 加载范围内（firstPage到lastPage之间）的所有页面
    for (NSInteger index = firstPage;index<=lastPage; index++) {
        [self loadPage:index];
    }
}


#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self loadVisiblePages];
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
