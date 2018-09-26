//
//  AQImageTitleTableViewCell.m
//  AiQiYiDemo
//
//  Created by ios2 on 2017/10/10.
//  Copyright © 2017年 ios2. All rights reserved.
//

#import "AQImageTitleTableViewCell.h"

@implementation AQImageTitleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
 //       self.contentView.bounds = [UIScreen mainScreen].bounds;
    
    _imagView_h.constant = ([UIScreen width]-4-10)/3.0f;
    _imageView_W.constant =([UIScreen width]-4-10)/3.0f;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _imageCountLable.layer.cornerRadius =7.0f;
    _imageCountLable.clipsToBounds = YES;
    


    _headerImageView.clipsToBounds = YES;
    _headerImageView.layer.cornerRadius = 20.0f;
    
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1507800178292&di=339e7cfe01ac407c020206272c44ba13&imgtype=jpg&src=http%3A%2F%2Fimg0.imgtn.bdimg.com%2Fit%2Fu%3D2551267984%2C2142599913%26fm%3D214%26gp%3D0.jpg"]];
    
    for (int i = 0; i<3; i++)
    {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        UIImageView *imgV = nil;
        switch (i) {
            case 0:
                imgV = _leftImageView;
                break;
            case 1:
                imgV = _centerImageView;
                break;
            case 2:
                imgV = _rightImageView;
                break;
            default:
                break;
        }
        [imgV addGestureRecognizer:tap];
        imgV.userInteractionEnabled = YES;
        imgV.tag = 10+i;
        imgV.clipsToBounds = YES;
        imgV.contentMode = UIViewContentModeScaleAspectFill;
    }
}

-(void)tapAction:(UITapGestureRecognizer *)tap
{
    if (tap.state==UIGestureRecognizerStateEnded)
    {
        if (_imageAction) {
            _imageAction((UIImageView *)tap.view);
        }
    }
}

-(void)configerImageCount:(NSInteger)imageCout andImageArray:(NSArray *)imgs
{
    if (imageCout>3) {
        _imageCountLable.hidden = NO;
        _imageCountLable.text = [NSString stringWithFormat:@"共%ld张",imageCout];
        [_leftImageView sd_setImageWithURL:[NSURL URLWithString:imgs[0]]];
        [_centerImageView sd_setImageWithURL:[NSURL URLWithString:imgs[1]]];
        [_rightImageView sd_setImageWithURL:[NSURL URLWithString:imgs[2]]];
        _leftImageView.hidden =NO;
        _centerImageView.hidden = NO;
        _rightImageView.hidden = NO;
    }else{
       _imageCountLable.hidden = YES;
    }
    
    if (imageCout==1) {
        _imageView_W.constant = 480/2.0f;
        _imagView_h.constant = 320/2.0f;
        [self.contentView layoutIfNeeded];
        
    }else{
           _imagView_h.constant = ([UIScreen width]-30)/3.0f;
          _imageView_W.constant = ([UIScreen width]-30)/3.0f;
           [self.contentView layoutIfNeeded];
    }
    switch (imageCout) {
        case 1:
            _leftImageView.hidden =NO;
            _centerImageView.hidden = YES;
            _rightImageView.hidden = YES;
           [_leftImageView sd_setImageWithURL:[NSURL URLWithString:imgs[0]]];
            break;
        case 2:
            _leftImageView.hidden =NO;
            _centerImageView.hidden = NO;
            [_leftImageView sd_setImageWithURL:[NSURL URLWithString:imgs[0]]];
            [_centerImageView sd_setImageWithURL:[NSURL URLWithString:imgs[1]]];
            _rightImageView.hidden = YES;
            break;
        case 3:
            _leftImageView.hidden =NO;
            _centerImageView.hidden = NO;
            _rightImageView.hidden = NO;
            [_leftImageView sd_setImageWithURL:[NSURL URLWithString:imgs[0]]];
            [_centerImageView sd_setImageWithURL:[NSURL URLWithString:imgs[1]]];
            [_rightImageView sd_setImageWithURL:[NSURL URLWithString:imgs[2]]];
            break;
        default:
            
            break;
    }
}

//- (CGSize)sizeThatFits:(CGSize)size {
//    CGFloat totalHeight = 0;
//    totalHeight += [self.headerImageView sizeThatFits:size].height;
//    
//    totalHeight += [self.msgTitle sizeThatFits:size].height;
//    totalHeight += [self.leftImageView sizeThatFits:size].height;
//    totalHeight += [self.fromLable sizeThatFits:size].height;
//    totalHeight += [self.sharrBtn sizeThatFits:size].height;
//    return CGSizeMake(size.width, totalHeight);
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
