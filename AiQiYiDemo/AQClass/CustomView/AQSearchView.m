//
//  AQSearchView.m
//  AiQiYiDemo
//
//  Created by ios2 on 2017/9/30.
//  Copyright © 2017年 ios2. All rights reserved.
//

#import "AQSearchView.h"

@implementation AQSearchView

{
    UILabel *_searchTextLable;
}

-(instancetype)initWithFrame:(CGRect)frame withSuperView:(UIView *)aView
{
    CGRect aframe  =  frame;
    CGRect rect  = [UIScreen mainScreen].bounds;
    
    aframe.origin.x = 0;
    
    aframe.origin.y = frame.origin.y;
    
    aframe.size.width = CGRectGetWidth(rect);
    
    aframe.size.height = (80)/2.0f;
    
    self  = [super initWithFrame:aframe];
    if (self)
    {
        [aView addSubview:self];
        [self addSearchSubView];
        self.backgroundColor = [UIColor colorWithHexString:@"#fefefe"];
    }
    
    return self;
}

-(void)addSearchSubView
{
    CGRect rect  = [UIScreen mainScreen].bounds;

    _containtView = [[UIView alloc]init];
    _containtView.x = px_scale(25);
    _containtView.width = CGRectGetWidth(rect)-px_scale(25*2);
    _containtView.height = px(75.0f);
    
    [self addSubview:_containtView];
    
    _containtView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    _containtView.clipsToBounds = YES;
    _containtView.layer.cornerRadius = px(75.0f)/2.0f;
    
    //添加手势
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ontap:)];
    
    [_containtView addGestureRecognizer:tap];
    
    //添加图片 右侧图片
    
    UIImageView *searchImageView = [[UIImageView alloc]init];
    
    searchImageView.centerX = CGRectGetWidth(_containtView.frame)-px_scale(30+42/2.0f);
    searchImageView.centerY = px(75.0f/2.0f);
    searchImageView.bounds = CGRectMake(0, 0, px_scale(42), px_scale(42));
    
    searchImageView.image = [UIImage imageNamed:@"search"];
    
    _searchRightImageView  = searchImageView;
    
    [_containtView addSubview:searchImageView];
    
    
    //添加左侧搜索图片
    UIImageView *leftSearchImgV = [[UIImageView alloc]init];
    //leftSearchImgV.hidden = YES;
    leftSearchImgV.image = [UIImage imageNamed:@"search_left"];
    leftSearchImgV.frame = (CGRect){px(30.0f),0,px(42),px(42)};
    leftSearchImgV.centerY =px(75.0f/2.0f);
	 leftSearchImgV.hidden = YES;
    [_containtView addSubview:leftSearchImgV];
     _searchLeftImageView = leftSearchImgV;
    
    //创建标签
    UILabel *textLable = [[UILabel alloc]init];
    
    textLable.font = [UIFont systemFontOfSize:14.0f];
    textLable.text = @"张杰乐子";
    
    CGFloat width =  [textLable.text widthForFont:textLable.font];
    
    textLable.textColor = [UIColor colorWithHexString:@"#999999"];
    [_containtView addSubview:textLable];
    
    textLable.frame = CGRectMake(([UIScreen width]-25-width)/2.0f, 0, width,  px(75.0f));
    
    textLable.textAlignment = NSTextAlignmentLeft;
    
    _searchTextLable = textLable;
    
    UITextField *tfInput = [[UITextField alloc]init];
    
    tfInput.frame = CGRectMake(px((30.0f+42)), 0,CGRectGetWidth([UIScreen mainScreen].bounds)-px_scale(20)-50.0f-px(35)-px(90.0f), px(60.0f));
    
    
    tfInput.centerY =px(75.0f/2.0f);
    
    
    [_containtView addSubview:tfInput];
    
    
    _searchTf.textColor = [UIColor colorWithHexString:@"#333333"];
    
    
    _searchTf.font = [UIFont systemFontOfSize:12.50f];

    tfInput.hidden = YES;

    _searchTf = tfInput;
    
    [_searchTf addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    
     _searchTf.delegate = self;
    
    _searchTf.returnKeyType = UIReturnKeySearch;
    _searchTf.tintColor = [UIColor colorWithHexString:@"#23d41e"];

    UIButton *calcelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [calcelBtn setTitle:@"取消" forState:UIControlStateNormal];
    
    [calcelBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
	 calcelBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    calcelBtn.hidden = YES;
    calcelBtn.frame =CGRectMake(CGRectGetWidth(rect)-px_scale(20)-50.0f, 0, 50.0f, 30.0f);
    
    calcelBtn.centerY =px(75.0f/2.0f);
    
    [calcelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:calcelBtn];
    
    _cancelBtn = calcelBtn;
 _removeTextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
 [_removeTextBtn setImage:[UIImage imageNamed:@"search_cancel"] forState:UIControlStateNormal];

 [_containtView addSubview:_removeTextBtn];
 _removeTextBtn.bounds = (CGRect){0,0,25,25};
 _removeTextBtn.centerX = CGRectGetWidth(rect)-px(60)-px(90)-px(25);
 _removeTextBtn.centerY =px(75/2.0f);
 _removeTextBtn.hidden = YES;
 [_removeTextBtn addTarget:self action:@selector(removeText:) forControlEvents:UIControlEventTouchUpInside];
}


//delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    if (textField.text.length>0)
    {
        if (_returnAction)
        {
            _returnAction(self,textField.text);
        }
    }
    return YES;
}



-(void)removeText:(id)sender
{
 _searchTf.text = @"";
 _removeTextBtn.hidden = YES;
  _searchTextLable.hidden  = NO;
}

-(void)cancelAction:(UIButton *)button
{
    [_searchTf resignFirstResponder];
 //点击取消
  _cancelBtn.hidden = YES;
  _searchTf.text = @"";
  _searchLable.hidden = NO;
  _searchRightImageView.hidden = NO;
  _searchLeftImageView.hidden = YES;
  _removeTextBtn.hidden = YES;
  _searchTextLable.hidden  = NO;
 
    if (_calcelAction) {
        _calcelAction(self);
    }
}

-(void)textChange:(UITextField *)tf
{
    if (_searchTf.text.length>0) {
        _searchTextLable.hidden  = YES;
	  _removeTextBtn.hidden = NO;
    }else{
        _searchTextLable.hidden = NO;
	     _removeTextBtn.hidden = YES;
    }
}


-(void)ontap:(UIGestureRecognizer *)tap
{
    if (tap.state ==UIGestureRecognizerStateEnded)
    {
        if (_searchAction)
        {
            _searchAction(self);
        }
    }
}

-(void)configSearchText:(NSString *)searchText
{
    _searchTextLable.text = searchText;
    _searchTextLable.width =  [_searchTextLable.text widthForFont:_searchTextLable.font];

}
#pragma mark GETTER

-(UILabel *)searchLable
{
    return _searchTextLable;
}






@end
