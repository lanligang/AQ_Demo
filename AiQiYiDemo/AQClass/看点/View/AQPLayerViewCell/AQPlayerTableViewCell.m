//
//  AQPlayerTableViewCell.m
//  AiQiYiDemo
//
//  Created by ios2 on 2017/10/10.
//  Copyright © 2017年 ios2. All rights reserved.
//

#import "AQPlayerTableViewCell.h"
#import <CLPlayerView.h>

@implementation AQPlayerTableViewCell
{
    CLPlayerView *_plaerView;
}
- (void)awakeFromNib {
    [super awakeFromNib];
       self.contentView.bounds = [UIScreen mainScreen].bounds;
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@""];
    // 创建图片图片附件
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = [UIImage imageNamed:@"top_title"];
    attach.bounds = CGRectMake(0, -5, 20, 20);
    
    NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
    
    [string appendAttributedString:attachString];
    
    NSString *str =@" 爱奇艺早班机: 早班机编辑部十一茶话会爱奇艺早班机......";
    
  NSMutableAttributedString *appendAbs =   [[NSMutableAttributedString alloc] initWithString:str];
    [appendAbs addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, str.length)];

    [string appendAttributedString:appendAbs];
    _titleTextView.attributedText = string;
    _titleTextView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _headerImageView.clipsToBounds = YES;
    _headerImageView.layer.cornerRadius = 20.0f;
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1507799958823&di=c16599a1187540417dcf2e09e11e5bce&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fforum%2Fw%3D580%2Fsign%3Ddfd607151b178a82ce3c7fa8c601737f%2Fc5f18a82b9014a90abf3bb64ac773912b11bee05.jpg"]];
    
    
    
    // NSString *regex_pound = @"#([^\\#|.]+)#";//话题的正则表达式
}

-(void)addPlyerView
{
    CGRect rect = [UIScreen mainScreen].bounds;
    CGFloat height =  (CGRectGetWidth(rect)-12.0f)*9/16.0f;
    CGFloat width =CGRectGetWidth(rect)-12.0f;
    CLPlayerView *plaerView = [[CLPlayerView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    [self.playerContaintView addSubview:plaerView];
    _plaerView = plaerView;
      [_plaerView playVideo];
     _plaerView.url = [NSURL URLWithString:@"http://wvideo.spriteapp.cn/video/2016/1117/5cd90c96-acb0-11e6-b83b-d4ae5296039d_wpc.mp4"];
}

//- (CGSize)sizeThatFits:(CGSize)size
//{
//    CGFloat totalHeight = 0;
//    totalHeight += [self.headerImageView sizeThatFits:size].height;
//    totalHeight+=12.5+16+30.0f;
//    totalHeight += [self.titleTextView sizeThatFits:size].height;
//    totalHeight += [self.shareBtn sizeThatFits:size].height;
//    totalHeight += [self.fromLable sizeThatFits:size].height;
//    totalHeight += [self.playerContaintView sizeThatFits:size].height;
//    return CGSizeMake(size.width, totalHeight);
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

@end
