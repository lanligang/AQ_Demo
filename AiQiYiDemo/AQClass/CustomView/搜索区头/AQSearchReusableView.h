//
//  AQSearchReusableView.h
//  AiQiYiDemo
//
//  Created by ios2 on 2017/10/9.
//  Copyright © 2017年 ios2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AQSearchReusableView : UICollectionReusableView


//区头title
@property (weak, nonatomic) IBOutlet UILabel *setionTitleLable;


//更多热搜按钮
@property (weak, nonatomic) IBOutlet UIButton *moreHotBtn;


//历史搜索删除
@property (weak, nonatomic) IBOutlet UIButton *historyDeleteBtn;

@property (nonatomic,copy)HeaderViewAction headerViewAction;





@end
