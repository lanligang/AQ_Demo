//
//  AQBaseViewController.m
//  AiQiYiDemo
//
//  Created by ios2 on 2017/9/30.
//  Copyright © 2017年 ios2. All rights reserved.
//

#import "AQBaseViewController.h"

#import "AQSearchView.h"

#import "NavTopView.h"

#import "SearchViewController.h"
#import "AQMoreHotViewController.h"
#import "MJRefresh.h"

@interface AQBaseViewController ()<UISearchBarDelegate>
{
    AQSearchView *_aqSearchView;
    NavTopView *_navView;
    BOOL _isUp;
  
    MJRefreshAutoNormalFooter *_refreshFooter;
    MJRefreshNormalHeader *_refreshHeader;
    
}

@property (nonatomic,strong)UISearchBar *searchBar;
@end

@implementation AQBaseViewController

void getFrameInfo(CFURLRef url, NSMutableArray *frames, NSMutableArray *delayTimes, CGFloat *totalTime,CGFloat *gifWidth, CGFloat *gifHeight,NSUInteger loopCount)
{
    CGImageSourceRef gifSource = CGImageSourceCreateWithURL(url, NULL);
    
    //获取gif的帧数
    size_t frameCount = CGImageSourceGetCount(gifSource);
    
    //获取GfiImage的基本数据
    NSDictionary *gifProperties = (__bridge NSDictionary *) CGImageSourceCopyProperties(gifSource, NULL);
    //由GfiImage的基本数据获取gif数据
    NSDictionary *gifDictionary =[gifProperties objectForKey:(NSString*)kCGImagePropertyGIFDictionary];
    //获取gif的播放次数 0-无限播放
    loopCount = [[gifDictionary objectForKey:(NSString*)kCGImagePropertyGIFLoopCount] integerValue];
    CFRelease((__bridge CFTypeRef)(gifProperties));
    
    for (size_t i = 0; i < frameCount; ++i) {
        //得到每一帧的CGImage
        CGImageRef frame = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);
        [frames addObject:[UIImage imageWithCGImage:frame]];
        CGImageRelease(frame);
        
        //获取每一帧的图片信息
        NSDictionary *frameDict = (__bridge NSDictionary*)CGImageSourceCopyPropertiesAtIndex(gifSource, i, NULL);
        
        //获取Gif图片尺寸
        if (gifWidth != NULL && gifHeight != NULL) {
            *gifWidth = [[frameDict valueForKey:(NSString*)kCGImagePropertyPixelWidth] floatValue];
            *gifHeight = [[frameDict valueForKey:(NSString*)kCGImagePropertyPixelHeight] floatValue];
        }
        
        //由每一帧的图片信息获取gif信息
        NSDictionary *gifDict = [frameDict valueForKey:(NSString*)kCGImagePropertyGIFDictionary];
        //取出每一帧的delaytime
        [delayTimes addObject:[gifDict valueForKey:(NSString*)kCGImagePropertyGIFDelayTime]];
        
        if (totalTime) {
            *totalTime = *totalTime + [[gifDict valueForKey:(NSString*)kCGImagePropertyGIFDelayTime] floatValue];
        }
        CFRelease((__bridge CFTypeRef)(frameDict));
    }
    CFRelease(gifSource);
}

-(NSDictionary *)getGifInfo:(NSURL *)fileURL
{
    NSMutableArray *frames = [NSMutableArray arrayWithCapacity:3];
    NSMutableArray *delays = [NSMutableArray arrayWithCapacity:3];
    NSUInteger loopCount = 0;
    CGFloat totalTime;         // seconds
    CGFloat width;
    CGFloat height;
    
    getFrameInfo((__bridge CFURLRef)fileURL, frames, delays, &totalTime, &width, &height, loopCount);
    NSDictionary *gifDic = @{@"images":frames,          //图片数组
                             @"delays":delays,          //每一帧对应的延迟时间数组
                             @"duration":@(totalTime),  //GIF图播放一遍的总时间
                             @"loopCount":@(loopCount), //GIF图播放次数  0-无限播放
                             @"bounds": NSStringFromCGRect(CGRectMake(0, 0, width, height))}; //GIF图的宽高
    return gifDic;
}
-(void)addPulDownRefresh
{
    
    NSString *path =   [[NSBundle mainBundle]pathForResource:@"4" ofType:@"gif" inDirectory:nil];
    
    return;
    NSDictionary *dic = [self getGifInfo:[NSURL fileURLWithPath:path]];
 // NSDictionary *dic2 = [self getGifInfo:[NSURL fileURLWithPath:path2]];
    
    NSMutableArray *headerImages = [NSMutableArray array];
    NSMutableArray *headerImages2 = [NSMutableArray array];
    
    [headerImages addObjectsFromArray:dic[@"images"]];
    [headerImages2 addObjectsFromArray:dic[@"images"]];

    WS(ws);
    MJRefreshGifHeader *gifHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        //下拉刷新要做的操作.
        [ws pullDownRefresh];
    }];
    gifHeader.stateLabel.hidden = YES;
    gifHeader.lastUpdatedTimeLabel.hidden = YES;
    
    [gifHeader setImages:headerImages2 forState:MJRefreshStateIdle];
    [gifHeader setImages:headerImages forState:MJRefreshStatePulling];
    [gifHeader setImages:headerImages forState:MJRefreshStateRefreshing];
    _aTableView.mj_header = gifHeader;
    
    //return;
    /*
    _refreshHeader = [MJRefreshNormalHeader new];
    _refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDownRefresh)];
    _refreshHeader.lastUpdatedTimeLabel.hidden = YES;// 隐藏时间
    [_refreshHeader setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [_refreshHeader setTitle:@"释放刷新" forState:MJRefreshStatePulling];
    [_refreshHeader setTitle:@"加载中" forState:MJRefreshStateRefreshing];
    _refreshHeader.stateLabel.font = [UIFont systemFontOfSize:13];
    _refreshHeader.stateLabel.textColor =[UIColor r:73/255.0f g:73/255.0f b:74/255.0f alphaComponent:1];;
    _aTableView.mj_header = _refreshHeader;
    */
    
}

-(void)pullDown:(BOOL)isPullDown pullUp:(BOOL)isPullUp
{
    if (isPullDown) {
        [self addPulDownRefresh];
    }
    if (isPullUp) {
        [self addPulUpMore];
    }
}

-(void)endRefresh
{
    [_aTableView.mj_header endRefreshing];
    [_aTableView.mj_footer endRefreshing];
}

-(void)pullDownRefresh
{
    //下拉刷新
}


-(void)addPulUpMore
{
    _refreshFooter = nil;
    
    _refreshFooter = [MJRefreshAutoNormalFooter new];
    _refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullUpMore)];
    _refreshFooter.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    
    _refreshFooter.stateLabel.hidden = NO;
    _refreshFooter.stateLabel.textColor = [UIColor r:73/255.0f g:73/255.0f b:74/255.0f alphaComponent:1];//(73, 73, 74);
    _refreshFooter.triggerAutomaticallyRefreshPercent = 5.0f;
    
    
    
    [_refreshFooter setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
    [_refreshFooter setTitle:@"松手加载" forState:MJRefreshStatePulling];
    [_refreshFooter setTitle:@"正在加载" forState:MJRefreshStateRefreshing];
    [_refreshFooter  setTitle:@"没有更多了" forState:MJRefreshStateNoMoreData];
    _refreshFooter.stateLabel.font = [UIFont systemFontOfSize:13.0f];
    _aTableView.mj_footer = _refreshFooter;
    
}

-(void)pullUpMore
{
    
}

-(void)pushToMoreHotVc
{
    AQMoreHotViewController *vc = [[AQMoreHotViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark 生命周期

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
 [self.view addSubview:self.searchContaintView];
 
 [self.view bringSubviewToFront:self.searchContaintView];
 
     CGRect rect =  [UIScreen mainScreen].bounds;
    _navView = [[NavTopView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(rect), KStatusBarHeight+px(107.0f)) withSuperView:self.view];
 
    _aqSearchView = [[AQSearchView alloc]initWithFrame:(CGRect){0,KStatusBarHeight+px(107.0f),0,px(70+34)} withSuperView:self.view];
     WS(ws);
   [_aqSearchView setCalcelAction:^(AQSearchView *aqSearchView) {
     [ws animationWithView:aqSearchView];
       //取消
     [ws cancelShowAction];
    }];
    [_aqSearchView setSearchAction:^(AQSearchView *searchView){
        [ws animationWithView:searchView];
        searchView.cancelBtn.hidden = NO;
        searchView.searchRightImageView.hidden = YES;
        searchView.searchLeftImageView.hidden = NO;
        [ws searchShowAction];
    }];
    
    [_aqSearchView setReturnAction:^(AQSearchView *searchView,NSString *text){
        SearchViewController *searchVc = [ws.childViewControllers firstObject];
        [searchVc saveText:text];
    }];
    
    [self.view addSubview:_aqSearchView];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
 //添加搜索vc
   [self addSearchChildViewController];
 
    _isUp = NO;
}
//调用子类方法
-(void)searchShowAction
{
    
}
//调用子类方法
-(void)cancelShowAction
{
    
}


-(void)addSearchChildViewController
{
 SearchViewController *searchVc = [[SearchViewController alloc]init];
    
    //设置滚动的block
    WS(ws);
    [searchVc setScrolldidScroll:^(UIScrollView *scrollView){
        [ws.view endEditing:YES];
    }];
    
    [searchVc setMoreHotAction:^(NSString *identifier,UIView *sender){
        [ws pushToMoreHotVc];
    }];

   [self addChildViewController:searchVc];
}
//显示搜索View
-(void)showSearchView
{
    self.tabBarController.tabBar.hidden = YES;
    [self addSearchChildViewController];
    UIView *searchView =   [self.childViewControllers[0] view];
    //执行向上动画
    [self.view addSubview:searchView];
    
    searchView.alpha = 0.5;
    
    CGFloat height =  [UIScreen height]-KStatusBarHeight-px(80)-KTabBarHeight;
    
    searchView.frame = (CGRect){0,height,[UIScreen width],height};
    
    
    [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:2.0 initialSpringVelocity:0.2 options:0 animations:^{
        searchView.frame = (CGRect){0,KStatusBarHeight+px(80),[UIScreen width],height};

    } completion:^(BOOL finished) {

    [UIView animateWithDuration:0.1 animations:^{
                searchView.alpha = 1.0f;
    }];
    }];
}



//隐藏搜索View
-(void)hiddenSeachView
{
  UIView *searchView =   [self.childViewControllers[0] view];
  UIViewController *searchVC =  self.childViewControllers[0];
    CGFloat height =  [UIScreen height]-KStatusBarHeight-px(80);
    //执行向下动画
    [UIView animateWithDuration:0.2 animations:^{
        
        searchView.frame = (CGRect){0,KStatusBarHeight+px(80)+px(107.0f),[UIScreen width],height};
        searchView.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [searchView removeFromSuperview];
            [searchVC removeFromParentViewController];
            self.tabBarController.tabBar.hidden = NO;
        }
    }];
}

//执行动画
-(void)animationWithView:(UIView *)animationView
{
    //变化到状态栏
    CGFloat y =KStatusBarHeight;
    CGFloat vX = px((30.0f+42));
    
    CGFloat nacY = 0;
    CGFloat cWidth = CGRectGetWidth([UIScreen mainScreen].bounds)-25.0f;
    [self.view bringSubviewToFront:_aqSearchView];
    
    if (_isUp)
    {
        _isUp = NO;
        y = KStatusBarHeight+px(107.0f);
        
        CGFloat lableWidth =   _aqSearchView.searchLable.width;
        vX = (cWidth-lableWidth)/2.0f;
      _aqSearchView.searchTf.hidden =YES;
	 [self hiddenSeachView];
    }else{
        _isUp = YES;
        cWidth -=px_scale(80.0f);
        
        nacY = -(KStatusBarHeight+px(107.0f));
        [_aqSearchView.searchTf becomeFirstResponder];
        _aqSearchView.searchTf.hidden =NO;
	  [self showSearchView];
    }
    
    [UIView animateWithDuration:0.2 animations:^{
       
        _aqSearchView.y = y;
        _aqSearchView.searchLable.x = vX;
        _aqSearchView.containtView.width = cWidth;
        _navView.y = nacY;
	  if (_subScrollView)
	  {
		if (_isUp)
		 {
		 _subScrollView.y = KStatusBarHeight+px(107.0f)+px(80);
		 _subScrollView.height = [UIScreen height]-KStatusBarHeight-px(80)-KTabBarHeight-px(107.0f);
		 }
	  }
    }];
}

-(void)setSearchText:(NSString *)searchText
{
    _searchText = searchText;
    [_aqSearchView configSearchText:searchText];
    
}

#pragma mark Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
 _subScrollView = scrollView;
 if (scrollView.isTracking==YES)
 {
  CGFloat offsetChangeY =  scrollView.contentOffset.y-_lastOffset;
 if (fabs(offsetChangeY)<=20) {
  return;
 }
 if (offsetChangeY<0) {
  //向下拉
  if (_aqSearchView.y==KStatusBarHeight)
  {
  [UIView animateWithDuration:0.1 animations:^{
	_aqSearchView.y = KStatusBarHeight+px(107.0f);
	_navView.y = 0;
	scrollView.y = KStatusBarHeight+px(107.0f)+px(80);
	 scrollView.height = [UIScreen height]-KStatusBarHeight-px(80)-KTabBarHeight-px(107.0f);
  } completion:^(BOOL finished) {
	if (finished) {
	}
  }];
  }
 }else{
  //向上拖拽
  if (_aqSearchView.y==KStatusBarHeight+px(107.0f))
	{
	[UIView animateWithDuration:0.1 animations:^{
	 _aqSearchView.y = KStatusBarHeight;
	 _navView.y =-(KStatusBarHeight+px(107.0f));
	 scrollView.y = KStatusBarHeight+px(80);
	 scrollView.height = [UIScreen height]-KStatusBarHeight-px(80)-KTabBarHeight;
	} completion:^(BOOL finished) {
	 if (finished) {
	  if (finished) {
	  }
	 }
	}];
	}
 }
 }
    _lastOffset = scrollView.contentOffset.y;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
