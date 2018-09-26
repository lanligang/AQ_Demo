//
//  AQLookPointViewController.m
//  AiQiYiDemo
//
//  Created by ios2 on 2017/9/30.
//  Copyright © 2017年 ios2. All rights reserved.
//

#import "AQLookPointViewController.h"
#import <CLPlayerView.h>
#import "AQPlayerTableViewCell.h"
#import "AQImageTitleTableViewCell.h"
#import "MSSBrowseDefine.h"
#import "TextTableViewCell.h"

@interface AQLookPointViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    AQPlayerTableViewCell *_cell;
    NSArray * _playeUrls;
    NSIndexPath *_cellIndexPath;//记录添加到那个cell上了
    
    NSInteger _coutCell;
}

/**CLplayer*/
@property (nonatomic, weak) CLPlayerView *playerView;

@property (nonatomic,strong)NSMutableDictionary *autoHeightCache;

@end

@implementation AQLookPointViewController



-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (_playerView) {
        [_playerView pausePlay];
    }
}

-(void)pullUpMore
{
    [self endRefresh];
    _coutCell+=5;
    [_lookPointTableView reloadData];
}

-(void)reloadTableView
{
      [_lookPointTableView reloadData];
};
-(void)pullDownRefresh
{
    [self endRefresh];
 
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"看点";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.lookPointTableView.y =  KStatusBarHeight+(107.0+80)/2.0f;
    self.lookPointTableView.height = [UIScreen height]-  KStatusBarHeight-(107.0+80)/2.0f-KTabBarHeight;
     self.lookPointTableView.width = [UIScreen width];
    [_lookPointTableView registerNib:[UINib nibWithNibName:@"AQPlayerTableViewCell" bundle:nil] forCellReuseIdentifier:@"playerCell"];
    [_lookPointTableView registerNib:[UINib nibWithNibName:@"AQImageTitleTableViewCell" bundle:nil] forCellReuseIdentifier:@"imgCell"];
    
    self.lookPointTableView.delegate = self;
    self.lookPointTableView.dataSource = self;
    
    self.aTableView = _lookPointTableView;
    [self pullDown:YES pullUp:YES];

   _lookPointTableView.fd_debugLogEnabled = NO;
    _coutCell = 5;

    NSArray *dataArray = @[@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"];
    _playeUrls = [dataArray copy];
    
    NSArray *subViews =  self.tabBarController.tabBar.subviews;
    for (UIView *suv in subViews)
    {
        if  ((suv.tag-10)==0)
        {
            for (UIView *subView in suv.subviews)
            {
                if ([subView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")])
                {
                  [subView aq_addRoaAnimation];;
                }
            }
            break;
        }
   }
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *key = [NSString stringWithFormat:@"%@",indexPath];
	NSNumber * heightNum =  self.autoHeightCache[key];
	if (heightNum) {
		return heightNum.floatValue;
	}
	return 44.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewAutomaticDimension;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 return _playeUrls.count+_coutCell;
}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell isKindOfClass:[AQPlayerTableViewCell class]])
    {
        if (indexPath.row==_cellIndexPath.row)
        {
            if (_playerView)
            {
                [_playerView pausePlay];
            }
        }
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = 	CGRectGetHeight(cell.frame);
	NSString *key = [NSString stringWithFormat:@"%@",indexPath];
	self.autoHeightCache[key] = @(cellHeight);
	
    if ([cell isKindOfClass:[AQPlayerTableViewCell class]]) {
        if (_cell==nil) {
           _cell = (AQPlayerTableViewCell *)cell;
        }
           if (_playerView==nil) {
            if (_cellIndexPath) {
                if (indexPath.row!=_cellIndexPath.row) {
                    return;
                }
            }
            _cellIndexPath = indexPath;
            CGRect rect = [UIScreen mainScreen].bounds;
            CGFloat height =  (CGRectGetWidth(rect)-12.0f)*9/16.0f;
            CGFloat width =CGRectGetWidth(rect)-12.0f;
            CLPlayerView *playerView = [[CLPlayerView alloc]initWithFrame:CGRectMake(0, 0, width, height)] ;
            playerView.url = [NSURL URLWithString:_playeUrls[0]];
            [playerView playVideo];
            [playerView backButton:^(UIButton *button) {
                NSLog(@"返回按钮被点击");
            }];
            playerView.isHiddenTool = YES;
            [playerView endPlay:^{        //销毁播放器
            }];
            _playerView = playerView;
            _playerView.mute = YES;//是否静音播放
            [_cell.playerContaintView addSubview:_playerView];
        }else{
            [_playerView playVideo];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if (indexPath.row==0)
    {
        cell =  [tableView dequeueReusableCellWithIdentifier:@"playerCell" forIndexPath:indexPath];
    }else{
        AQImageTitleTableViewCell *imgTitleCell =[tableView dequeueReusableCellWithIdentifier:@"imgCell" forIndexPath:indexPath];
        NSArray *bigUrlArray = @[@"http://img.wdjimg.com/image/video/945fa937f0955b31224314a4eeef59b8_0_0.jpeg"];
        NSArray *imgsurl = @[
                             @"http://wimg.spriteapp.cn/picture/2016/0317/56ea981c857df__82.jpg",
                             @"http://wimg.spriteapp.cn/picture/2016/0616/57620c1f354ae_31.jpg",
                             @"http://wimg.spriteapp.cn/picture/2016/1203/58425ad2a0c1d_wpd_18_91.jpg",
                             @"http://wimg.spriteapp.cn/picture/2016/0503/572802026dcd4_64.jpg",
                             @"http://wimg.spriteapp.cn/picture/2016/1118/582ee6ed3a5d6_wpd_87.jpg",
                             @"http://wimg.spriteapp.cn/picture/2016/0506/572c0236200e7__b.jpg",
                             @"http://wimg.spriteapp.cn/picture/2015/0820/55d5addd8d4c9_wpd.jpg"];
        bigUrlArray =  (indexPath.row%2==1)?bigUrlArray:imgsurl;

        [imgTitleCell setImageAction:^(UIImageView *actionImagView) {

            NSMutableArray *browseItemArray = [[NSMutableArray alloc]init];
            for(int  i = 0;i < [bigUrlArray count];i++)
            {
                MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
                browseItem.bigImageUrl = bigUrlArray[i];// 加载网络图片大图地址
                UIImageView *imageView = nil;
                if (i==0) {
                    imageView = imgTitleCell.leftImageView;
                }else if (i==1){
                    imageView = imgTitleCell.centerImageView;
                }else if (i==2){
                    imageView = imgTitleCell.rightImageView;
                }else{
                    imageView = imgTitleCell.rightImageView;
                }
                browseItem.smallImageView = imageView;// 小图
                [browseItemArray addObject:browseItem];
            }
            MSSBrowseNetworkViewController *bvc = [[MSSBrowseNetworkViewController alloc]initWithBrowseItemArray:browseItemArray currentIndex:actionImagView.tag-10];
            [bvc showBrowseViewController];
        }];

        cell = imgTitleCell;
        [cell setSelectionStyle:0];
    }
 cell.backgroundColor = [UIColor whiteColor];
 return cell;
}
-(void)searchShowAction
{
    [super searchShowAction];
    if (_playerView)
    {
     [_playerView pausePlay];
    }
}
-(void)cancelShowAction
{
    [super cancelShowAction];
    
    if (_playerView)
    {
        [_playerView playVideo];
    }
}
-(NSMutableDictionary *)autoHeightCache
{
	if (!_autoHeightCache)
	 {
		_autoHeightCache = [[NSMutableDictionary alloc]init];
	 }
	return _autoHeightCache;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
