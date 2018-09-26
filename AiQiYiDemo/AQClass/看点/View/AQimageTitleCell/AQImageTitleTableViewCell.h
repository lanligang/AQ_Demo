//
//  AQImageTitleTableViewCell.h
//  AiQiYiDemo
//
//  Created by ios2 on 2017/10/10.
//  Copyright © 2017年 ios2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AQImageTitleTableViewCell : UITableViewCell



@property (nonatomic,copy)void(^imageAction)(UIImageView *actionImagView);


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imagView_h;

@property (weak, nonatomic) IBOutlet UILabel *imageCountLable;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageCount_w;

//图片的宽度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageView_W;
//左边图片
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
//中间图片
@property (weak, nonatomic) IBOutlet UIImageView *centerImageView;
//右边图片
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;

@property (weak, nonatomic) IBOutlet UILabel *msgTitle;
//头像
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *fromLable;


@property (weak, nonatomic) IBOutlet UIButton *sharrBtn;

-(void)configerImageCount:(NSInteger)imageCout andImageArray:(NSArray *)imgs;


@end
