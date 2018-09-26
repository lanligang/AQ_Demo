//
//  TextTableViewCell.h
//  AiQiYiDemo
//
//  Created by ios2 on 2018/1/2.
//  Copyright © 2018年 ios2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextTableViewCell : UITableViewCell

@property (nonatomic,strong)NSString *textStr;
@property (weak, nonatomic) IBOutlet UILabel *textLable;



@end
