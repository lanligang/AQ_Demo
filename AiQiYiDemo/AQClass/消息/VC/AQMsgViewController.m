//
//  AQMsgViewController.m
//  AiQiYiDemo
//
//  Created by ios2 on 2017/9/30.
//  Copyright © 2017年 ios2. All rights reserved.
//

#import "AQMsgViewController.h"
#import <SwipeTableView.h>
#import "SwiperHeaderView.h"

@interface AQMsgViewController ()
<SwipeTableViewDelegate,
SwipeTableViewDataSource,
UITableViewDelegate,
UITableViewDataSource>


@property (nonatomic,strong)SwipeTableView *swipeTableView;

@property (nonatomic,strong)SwiperHeaderView *tableViewHeader;

@end

@implementation AQMsgViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.swipeTableView = [[SwipeTableView alloc]initWithFrame:self.view.bounds];
    _swipeTableView.swipeHeaderTopInset = 0;
    
    _swipeTableView.delegate = self;
    _swipeTableView.dataSource = self;
    _swipeTableView.shouldAdjustContentSize = YES;
    _swipeTableView.swipeHeaderView = self.tableViewHeader;
    _swipeTableView.swipeHeaderBarScrollDisabled = YES;
    UIView *view = [UIView new];
    view.backgroundColor =[UIColor greenColor];
    view.frame = CGRectMake(0, 0, [UIScreen width], 60.0f);
    _swipeTableView.swipeHeaderBar = view;
    [self.view addSubview:self.swipeTableView];
    
}
-(SwiperHeaderView *)tableViewHeader
{
    if (!_tableViewHeader)
    {
        _tableViewHeader = [[SwiperHeaderView alloc]init];
        _tableViewHeader.backgroundColor = [UIColor yellowColor];
        _tableViewHeader.frame = CGRectMake(0, 0, [UIScreen width], 300.0f);
    }
    return _tableViewHeader;
}

- (NSInteger)numberOfItemsInSwipeTableView:(SwipeTableView *)swipeView {
    return 4;
}

- (void)swipeTableView:(SwipeTableView *)swipeView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---------滚动到第几个了---------------%ld",(long)index);
}
- (void)swipeTableViewCurrentItemIndexDidChange:(SwipeTableView *)swipeView
{
     NSLog(@"---------滚动到第几个了---------------%ld",swipeView.currentItemIndex);
}
- (void)swipeTableViewDidScroll:(SwipeTableView *)swipeView
{
    NSLog(@"---------滚动到第几个了---------------%ld",swipeView.currentItemIndex);
}

- (UIScrollView *)swipeTableView:(SwipeTableView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIScrollView *)view {
    UITableView * tableView = (UITableView *)view;
    if (nil == tableView) {
        tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = [UIColor redColor];
    
    }
    // 这里刷新每个item的数据
   // [tableVeiw refreshWithData:dataArray];

    return tableView;
}
- (BOOL)swipeTableView:(SwipeTableView *)swipeTableView shouldPullToRefreshAtIndex:(NSInteger)index
{
    return NO;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    cell =  [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return CGFLOAT_MIN;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
