//
//  TableViewBlock.h
//  AiQiYiDemo
//
//  Created by Macx on 2017/10/7.
//  Copyright © 2017年 ios2. All rights reserved.
//

#ifndef TableViewBlock_h
#define TableViewBlock_h
#if __OBJC__

typedef void(^TableViewSelete)(NSIndexPath *indexPath,UITableView *tableView);


typedef void(^CollectionSeleteBlock)(NSIndexPath *indexPath,UICollectionView *collectionView);


typedef void(^ScrollDidScrollBlock)(UIScrollView *scrollView);


typedef void(^HeaderViewAction)(NSString  *identifier,UIView *sender);



#endif
#endif
