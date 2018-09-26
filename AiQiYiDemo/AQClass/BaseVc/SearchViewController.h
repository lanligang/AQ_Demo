//
//  SearchViewController.h
//  AiQiYiDemo
//
//  Created by Macx on 2017/10/8.
//  Copyright © 2017年 ios2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchDelegateModel.h"

@interface SearchViewController : UIViewController

@property (nonatomic, strong) SearchDelegateModel		*delegateModel;

@property (weak, nonatomic) IBOutlet UICollectionView *searchCollectionView;


@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;


@property (nonatomic,copy)ScrollDidScrollBlock scrolldidScroll;

@property (nonatomic,copy)HeaderViewAction moreHotAction;




-(void)saveText:(NSString *)text;

//重新加载
-(void)reloadCollectionView;

@end
