//
//  AQMoreHotViewController.m
//  AiQiYiDemo
//
//  Created by ios2 on 2017/10/9.
//  Copyright © 2017年 ios2. All rights reserved.
//

#import "AQMoreHotViewController.h"

@interface AQMoreHotViewController ()

@end

@implementation AQMoreHotViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
 
}

- (void)didReceiveMemoryWarning
{
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
