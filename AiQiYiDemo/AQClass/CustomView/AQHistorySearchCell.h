//
//  AQHistorySearchCell.h
//  AiQiYiDemo
//
//  Created by ios2 on 2017/10/9.
//  Copyright © 2017年 ios2. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol AQHistoryDelegate<NSObject>

-(void)historyCellHeight:(CGFloat)cellHeight;

@end

@interface AQHistorySearchCell : UICollectionViewCell



@property(nonatomic,assign)id delegate;



@property (nonatomic,strong)NSArray *titlesArray;



@property (nonatomic,copy)void(^historyItemAction)(NSString * itemStr,AQHistorySearchCell *cell);

@property (nonatomic,copy)void(^cellHeightReset)(CGFloat cellHeight,AQHistorySearchCell *cell);



@end






