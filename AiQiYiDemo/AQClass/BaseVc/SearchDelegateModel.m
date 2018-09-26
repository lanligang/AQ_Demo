//
//  SearchDelegateModel.m
//  AiQiYiDemo
//
//  Created by Macx on 2017/10/7.
//  Copyright © 2017年 ios2. All rights reserved.
//

#import "SearchDelegateModel.h"

//历史搜索cell
#import "AQHistorySearchCell.h"
//热搜cell
#import "AQSearchHotCell.h"
//区头
#import "AQSearchReusableView.h"
#import "SaveTool.h"
#import "NSString+YYAdd.h"


@implementation SearchDelegateModel{
    CGFloat _cellHeight;
}


-(instancetype)initWithCollectionView:(UICollectionView *)collectionView
{
 self = [super init];
 if (self)
 {
  _cellHeight= 0.0f;
  self.collectionView = collectionView;
  _collectionView.delegate = self;
  _collectionView.dataSource = self;
  _collectionView.backgroundColor = [UIColor whiteColor];
     
  [_collectionView registerNib:[UINib nibWithNibName:@"AQSearchHotCell" bundle:nil] forCellWithReuseIdentifier:@"hotCell"];
     
  [_collectionView registerNib:[UINib nibWithNibName:@"AQHistorySearchCell" bundle:nil] forCellWithReuseIdentifier:@"historyCell"];
     

  //注册区头
  [_collectionView registerNib:[UINib nibWithNibName:@"AQSearchReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
     
     
 }
 return self;
}


/****************************************************/
#pragma mark UICollectionViewDataSource&UIcollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat height =(20+15+10);
    if (section==0)
    {
        if (self.historyArray.count==0)
        {
            height = 0;
        }
    }
  return CGSizeMake([UIScreen width], height);
    
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        AQSearchReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
        WS(ws);
        [headerView setHeaderViewAction:^(NSString *identifier,UIView *deleteBtn){
            if ([identifier isEqualToString:@"delete"]) {
                [ws.collectionView reloadData];
            }else if ([identifier isEqualToString:@"hotMore"]){
                //更多热搜
                if (ws.headerAction) {
                    ws.headerAction(identifier,deleteBtn);
                }
            }
        }];

        if (indexPath.section==0) {
            headerView.setionTitleLable.text = @"搜索历史";
            headerView.historyDeleteBtn.hidden = NO;
            headerView.moreHotBtn.hidden = YES;
            
        }else{
            headerView.setionTitleLable.text = @"热门搜索";
            headerView.historyDeleteBtn.hidden = YES;
            headerView.moreHotBtn.hidden = (self.hotSearchDataSource.count>10)?NO:YES;

        }

        reusableview = headerView;
    }
    
    return reusableview;
}




-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==0) {
        return (self.historyArray.count>0)?1:0;
    }else{
        NSInteger hotCount = self.hotSearchDataSource.count;
        
        return (hotCount>10?10:hotCount);
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = nil;
    
    if (indexPath.section==0)
    {
       AQHistorySearchCell * historyCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"historyCell" forIndexPath:indexPath];
        
        historyCell.titlesArray = self.historyArray;

       [historyCell setHistoryItemAction:^(NSString *title,AQHistorySearchCell *htCell){
           NSLog(@"点击了--| %@",title);
        }];
        cell = historyCell;
    }else{
        
       AQSearchHotCell *hotCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"hotCell" forIndexPath:indexPath];
        
        NSArray *colorStrs = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"color_list.plist" ofType:nil]];
        
        NSString *colorStr = indexPath.row>2?colorStrs[3]:colorStrs[indexPath.row];
        
        hotCell.hotNumLable.backgroundColor = [UIColor colorWithHexString:colorStr];
        hotCell.hotNumLable.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
        hotCell.hotContaintLable.text  = self.hotSearchDataSource[indexPath.row];
        cell = hotCell;
    }
    
    cell.backgroundColor = [UIColor whiteColor];
   return cell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section==1) {
       CGFloat width =   [UIScreen width]/2.0f-px(50.0f)-px((40-25));
       return (CGSize){width,px(60.0f)};
        
    }else{
        
      return (CGSize){[UIScreen width]-10,[self historyHeight]};
    }
}

-(CGFloat)historyHeight
{
  __block  CGFloat  width = 0.0f;
  __block CGFloat lastX = px(25);
  __block CGFloat height = 0.0f;
    
    [self.historyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               NSString *title =    (NSString *)obj;
               width =   [title widthForFont:[UIFont systemFontOfSize:13.0f]]+25.0f;
        
        if (idx==0) {
            lastX =px(25)+width;
            height = px(15.0f);
        }else{
            lastX+=(px(30.0f)+width);
        }
        
        CGFloat maxX =lastX+px(30.0f)+25.0f;
        if ((maxX)>[UIScreen width])
        {
            height += px(50.0f)+15.0f;
            lastX = px(25.0f)+width;
        }
        
    }];
    return height;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1)
    {
        if (_collectionSeleted)
        {
            _collectionSeleted(indexPath,collectionView);
        }
    }

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_scrollViewDidScroll)
    {
        _scrollViewDidScroll(scrollView);
    }
}


-(instancetype)initWithTableView:(UITableView *)tableView
{
 self = [super init];
 if (self)
 {
 self.tableView = tableView;
 
 [_tableView registerClass:[UITableView class] forCellReuseIdentifier:@"cell"];
 
 }
 return self;
}

-(void)reloaddata
{
 if (_tableView)
 {
   [_tableView reloadData];
 }else if (_collectionView){
  [_collectionView reloadData];
 }
}

#pragma mark Delegate&DataSource
#pragma mark - ****************tableview Delegate && DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
 return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
 static NSString *identifier = @"cell";
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
 
 if (!cell)
  {
  cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
  }
 [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
 
 
 return cell;
 
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
 [tableView deselectRowAtIndexPath:indexPath animated:NO];
 if (_tableSeleted) {
  _tableSeleted(indexPath,tableView);
 }
 
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
 return 44;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
 return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
 
 return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
 return 0.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
 
 return nil;
 
}


-(void)setTableView:(UITableView *)tableView
{
 _tableView = tableView;
 _tableView.delegate = self;
 _tableView.dataSource = self;
}
-(NSMutableArray *)hotSearchDataSource
{
 if (_hotSearchDataSource==nil)
  {
  _hotSearchDataSource = [[NSMutableArray alloc]initWithArray:@[@"关晓彤",@"鹿晗",@"张家集",@"校门口的菜",@"关晓彤",@"鹿晗",@"张家集",@"校门口校门口校门口的菜",@"鹿校门口晗",@"张家集",@"校门口的菜",@"关晓彤",@"鹿晗",@"张家集校门口校门口",@"校门口的菜",@"鹿校门口晗",@"张家集",@"校门口的菜",@"关晓彤",@"鹿晗",@"张家集",@"校门口的菜",@"鹿晗",@"张家集校门口校门口",@"校门口的菜",@"关晓彤",@"鹿晗",@"张家集",@"校门口的菜"]];
  }
 return _hotSearchDataSource;
}
-(NSMutableArray *)historyArray
{
    return  [[SaveTool findHistorySearch] mutableCopy];
   
}

-(void)addHistoryString:(NSString *)searchStr;
{
    [SaveTool saveStrToUserDefault:searchStr];
    [_collectionView reloadData];
}



@end
