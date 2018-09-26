//
//  TextTableViewCell.m
//  AiQiYiDemo
//
//  Created by ios2 on 2018/1/2.
//  Copyright © 2018年 ios2. All rights reserved.
//

#import "TextTableViewCell.h"

@implementation TextTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _textLable.numberOfLines = 0;
    //利用
    _textLable.preferredMaxLayoutWidth = 20.0f;
}
-(void)setTextStr:(NSString *)textStr
{
    _textStr = textStr;
    _textLable.text = textStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
