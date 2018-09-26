//
//  AQHistorySearchCell.m
//  AiQiYiDemo
//
//  Created by ios2 on 2017/10/9.
//  Copyright © 2017年 ios2. All rights reserved.
//

#import "AQHistorySearchCell.h"

@implementation AQHistorySearchCell{
    NSMutableArray *_lableArray;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.clipsToBounds = NO;
    self.backgroundColor = [UIColor redColor];
    _lableArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<8; i++)
    {
        UILabel *lable = [[UILabel alloc]init];
        lable.layer.cornerRadius  = px(50.0f)/2.0f;
        lable.clipsToBounds = YES;
        lable.hidden = YES;
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:12.0f];
        lable.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
        lable.tag = i+100;
        lable.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ontap:)];
        [lable addGestureRecognizer:tap];
        
        [self.contentView addSubview:lable];
    }
    
}

#pragma mark 点击Item
-(void)ontap:(UIGestureRecognizer *)tap
{
    if (tap.state==UIGestureRecognizerStateEnded)
    {
        UILabel *historyLable = (UILabel *)tap.view;
        if (_historyItemAction)
        {
            _historyItemAction(historyLable.text,self);
        }
    }
}



-(void)setTitlesArray:(NSArray *)titlesArray
{
    _titlesArray = titlesArray;
 __block   CGFloat cellHeight = 0.0f;
    
    [self.contentView.subviews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat  width = 0;
        UILabel *lable = obj;

        if (idx<_titlesArray.count)
        {
            NSString *title = _titlesArray[idx];
            lable.text = title;
           width =   [title widthForFont:[UIFont systemFontOfSize:13.0f]]+25.0f;
            if (idx==0)
            {
                
                lable.frame = CGRectMake(px(25), 0, width, px(50.0f));
                
            }else{
                
                UILabel *lastLable =self.contentView.subviews[idx-1];
                
                CGFloat maxX =   CGRectGetMaxX(lastLable.frame)+px(30.0f)+width+25.0f/2.0f;
                
                if (maxX>[UIScreen width])
                {
                    lable.frame = CGRectMake(px(25), CGRectGetMaxY(lastLable.frame)+px(30.0f), width, px(50.0f));
                }else{
                    lable.frame = CGRectMake(CGRectGetMaxX(lastLable.frame)+px(30.0f), lastLable.frame.origin.y, width, px(50.0f));
                }
                
            }
            lable.hidden = NO;
            cellHeight = CGRectGetMaxY(lable.frame);
        }else{
            lable.text = @"";
            lable.hidden = YES;
        }
        
    }];
    if ([_delegate respondsToSelector:@selector(historyCellHeight:)]) {
        [_delegate historyCellHeight:cellHeight];
    }
    
    
}


@end


