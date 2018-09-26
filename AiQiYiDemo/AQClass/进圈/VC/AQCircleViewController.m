//
//  AQCircleViewController.m
//  AiQiYiDemo
//
//  Created by ios2 on 2017/9/30.
//  Copyright © 2017年 ios2. All rights reserved.
//

#import "AQCircleViewController.h"
#import <IosMath/IosMath.h>
#import "MTMathUILabel.h"

@interface AQCircleViewController ()

@end

@implementation AQCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	MTMathUILabel* label = [[MTMathUILabel alloc] init];
	label.textAlignment = kMTTextAlignmentCenter;
	label.fontSize = 17.0f;
	label.backgroundColor = [UIColor yellowColor];
	label.textColor = [UIColor redColor];
	NSString *str = @"\\frac{\\partial^2 x}{\\partial x^2}";
	label.latex =str;
	CGSize size = 	[label sizeThatFits:CGSizeMake(CGRectGetWidth(self.view.frame), CGFLOAT_MAX)];
	[self.view addSubview:label];
	[label mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(0);
		make.centerY.mas_equalTo(0);
	}];
	NSLog(@"输出大小 \n|%@",@(size));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
