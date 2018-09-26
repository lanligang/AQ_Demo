//
//  AQSearchReusableView.m
//  AiQiYiDemo
//
//  Created by ios2 on 2017/10/9.
//  Copyright © 2017年 ios2. All rights reserved.
//

#import "AQSearchReusableView.h"
#import "SaveTool.h"

@implementation AQSearchReusableView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.clipsToBounds = YES;
    
    
}



- (IBAction)historyDeleteAction:(UIButton *)sender {
    
    //删除按钮
    [SaveTool removeAllHistory];
    if (_headerViewAction)
    {
        _headerViewAction(@"delete",sender);
    }
}



- (IBAction)hotMoreAction:(UIButton *)sender
{
    //点击更多热搜词
    _headerViewAction(@"hotMore",sender);
}

@end
