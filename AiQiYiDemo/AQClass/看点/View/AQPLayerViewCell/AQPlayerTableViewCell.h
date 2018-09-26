//
//  AQPlayerTableViewCell.h
//  AiQiYiDemo
//
//  Created by ios2 on 2017/10/10.
//  Copyright © 2017年 ios2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AQPlayerTableViewCell : UITableViewCell



//播放器要添加的View
@property (weak, nonatomic) IBOutlet UIView *playerContaintView;

//播放器要添加的VIew的高度约束 按照16:9约束
@property (weak, nonatomic) IBOutlet UITextView *titleTextView;

//头像
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

//头部标签文字

//来源
@property (weak, nonatomic) IBOutlet UILabel *fromLable;

//分享按钮
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;


@end
