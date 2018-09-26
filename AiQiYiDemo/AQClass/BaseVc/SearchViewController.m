//
//  SearchViewController.m
//  AiQiYiDemo
//
//  Created by Macx on 2017/10/8.
//  Copyright © 2017年 ios2. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
 _delegateModel =  [[SearchDelegateModel alloc]initWithCollectionView:self.searchCollectionView];
  CGFloat height =  [UIScreen height]-KStatusBarHeight-px(80);
 _searchCollectionView.frame =(CGRect){0,0,[UIScreen width],height};
    
  _flowLayout.sectionInset = UIEdgeInsetsMake(0, 15.0f, 15.0f, 15.0f);
    
 WS(ws);
    

    [self.delegateModel setHeaderAction:^(NSString *identifier,UIView *sender){
        ws.moreHotAction(identifier,sender);
    }];
 
    //选中Cell
 [_delegateModel setCollectionSeleted:^(NSIndexPath *indexPath, UICollectionView *collectionView) {
     
  UIViewController *vc = [[UIViewController alloc]init];
  vc.view.backgroundColor = [UIColor redColor];
     
  [ws.navigationController pushViewController:vc animated:YES];
 
     
   [vc.navigationController setNavigationBarHidden:NO animated:YES];
 }];
    
 _delegateModel.scrollViewDidScroll = _scrolldidScroll;
    
}

-(void)reloadCollectionView
{
 
    _delegateModel = nil;
    
    for (UIView *v in self.view.subviews) {
        if ([v isKindOfClass:[UICollectionView class]]) {
            self.searchCollectionView = (UICollectionView *)v;
        }
    }
   _delegateModel =  [[SearchDelegateModel alloc]initWithCollectionView:self.searchCollectionView];
}


-(void)saveText:(NSString *)text
{
    [_delegateModel addHistoryString:text];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
