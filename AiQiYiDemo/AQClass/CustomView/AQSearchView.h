//
//  AQSearchView.h
//  AiQiYiDemo
//
//  Created by ios2 on 2017/9/30.
//  Copyright © 2017年 ios2. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AQSearchView;

typedef void(^SearchAction)(AQSearchView *aqSearchView);

typedef void(^CancelAction)(AQSearchView *aqSearchView);

typedef void(^ReturnAction)(AQSearchView *aqSearchView,NSString *text);


@interface AQSearchView : UIView<UITextFieldDelegate>

//点击整个搜索部分调用
@property (nonatomic,copy)SearchAction searchAction;

//取消的时候调用
@property (nonatomic,copy)CancelAction calcelAction;

//键盘return的时候调用
@property (nonatomic,copy)ReturnAction returnAction;



@property (nonatomic,strong)UIImageView *searchRightImageView;

@property (nonatomic, strong) UIImageView		*searchLeftImageView;

@property (nonatomic,strong)UIButton *cancelBtn;


@property (nonatomic,strong)UILabel *searchLable;

@property (nonatomic, strong) UIButton		*removeTextBtn;


@property (nonatomic,strong)UIView *containtView;
@property (nonatomic,strong)UITextField *searchTf;


-(instancetype)initWithFrame:(CGRect)frame withSuperView:(UIView *)aView;

-(void)configSearchText:(NSString *)searchText;

@end
