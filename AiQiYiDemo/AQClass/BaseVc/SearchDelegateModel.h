//
//  SearchDelegateModel.h
//  AiQiYiDemo
//
//  Created by Macx on 2017/10/7.
//  Copyright © 2017年 ios2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchDelegateModel : NSObject<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@property (nonatomic, copy) TableViewSelete tableSeleted;

@property (nonatomic, copy) CollectionSeleteBlock collectionSeleted;

@property (nonatomic, copy) ScrollDidScrollBlock    scrollViewDidScroll;

@property(nonatomic,copy)HeaderViewAction headerAction;




@property (nonatomic, strong) UITableView		*tableView;
@property (nonatomic, strong) UICollectionView		*collectionView;

@property (nonatomic, strong) NSMutableArray		*hotSearchDataSource;

@property (nonatomic,strong)NSMutableArray *historyArray;



-(instancetype)initWithTableView:(UITableView *)tableView;

-(instancetype)initWithCollectionView:(UICollectionView *)collectionView;

//刷新tableView&&刷新CollectionView 同样选其一
-(void)reloaddata;

//添加搜索的文字
-(void)addHistoryString:(NSString *)searchStr;



@end
