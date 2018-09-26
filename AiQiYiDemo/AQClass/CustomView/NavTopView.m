//
//  NavTopView.m
//  AiQiYiDemo
//
//  Created by ios2 on 2017/9/30.
//  Copyright © 2017年 ios2. All rights reserved.
//

#import "NavTopView.h"

@implementation NavTopView



-(instancetype)initWithFrame:(CGRect)frame withSuperView:(UIView *)superView
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        
        [superView addSubview:self];
        
        self.backgroundColor = [UIColor colorWithHexString:@"#fefefe"];

        [self addUI];
        
    }
    return self;
    
}

-(void)action:(UIButton *)button
{
    
    if (button.tag==2022)
    {
        //点击了头像
    }else if (button.tag==2023)
    {
        //点击了通讯录
    }
    
}

-(void)addUI
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.tag = 2022;
    
    [self addSubview:rightBtn];
    
    UIButton *addBookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //通讯录按钮
    [addBookBtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    
    addBookBtn.tag = 2023;
    
    addBookBtn.backgroundColor = [UIColor greenColor];
    
    [self addSubview:addBookBtn];

    rightBtn.backgroundColor = [UIColor redColor];
    
    
    
    UILabel *titleLable = [[UILabel alloc]init];
    titleLable.font  = [UIFont systemFontOfSize:px(38.0f)];
    
    [self addSubview:titleLable];
    
    titleLable.textColor = [UIColor colorWithHexString:@"#333333"];
    
    titleLable.text = @"看点";
    
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(px(38.0f));
        make.top.mas_equalTo(KStatusBarHeight+px(31.0f));
    }];
    
    
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-px(25));
        make.width.mas_equalTo(px(64));
        make.height.mas_equalTo(px(64));
        make.centerY.equalTo(titleLable.mas_centerY);
    }];
    
[addBookBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(rightBtn.mas_left).offset(-px(34.0f));
    make.height.mas_equalTo(px(45.0f));
    make.width.mas_equalTo(px(45.0f));
    make.centerY.mas_equalTo(rightBtn.mas_centerY);
    
}];
    
    
}




@end
