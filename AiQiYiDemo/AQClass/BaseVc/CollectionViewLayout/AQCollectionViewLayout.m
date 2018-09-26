//
//  AQCollectionViewLayout.m
//  AiQiYiDemo
//
//  Created by ios2 on 2017/10/9.
//  Copyright © 2017年 ios2. All rights reserved.
//

#import "AQCollectionViewLayout.h"

@implementation AQCollectionViewLayout


- (CGSize)collectionViewContentSize
{
    if (_aHeight+15.0f<self.collectionView.height) {
        return CGSizeMake([UIScreen width],self.collectionView.height+0.5);
    }
    return CGSizeMake([UIScreen width], _aHeight+15.f);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    NSMutableArray* attributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    
    UICollectionViewLayoutAttributes *lastLayoutAttributes =  [attributes lastObject];
    
     _aHeight =  CGRectGetMaxY(lastLayoutAttributes.frame);
    return attributes;
}




@end
