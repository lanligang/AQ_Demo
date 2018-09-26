//
//  AQBaseViewController.h
//  AiQiYiDemo
//
//  Created by ios2 on 2017/9/30.
//  Copyright © 2017年 ios2. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface AQBaseViewController : UIViewController<UIScrollViewDelegate>
{
 UIScrollView *_subScrollView;
}

//搜索view的顶部约束

//搜索结果的View
@property (strong, nonatomic)  UIView *searchContaintView;

@property (nonatomic, assign) CGFloat lastOffset;

@property (nonatomic,strong)NSString *searchText;

@property (nonatomic,strong)UITableView *aTableView;

-(void)pullDown:(BOOL)isPullDown pullUp:(BOOL)isPullUp;
//下拉刷新
-(void)pullDownRefresh;
//上拉加载更多
-(void)pullUpMore;
//结束刷新
-(void)endRefresh;

-(void)searchShowAction;

-(void)cancelShowAction;

@end
