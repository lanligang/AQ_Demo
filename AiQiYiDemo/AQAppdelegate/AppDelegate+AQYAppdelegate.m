//
//  AppDelegate+AQYAppdelegate.m
//  AiQiYiDemo
//
//  Created by ios2 on 2017/9/30.
//  Copyright © 2017年 ios2. All rights reserved.
//

#import "AppDelegate+AQYAppdelegate.h"

@implementation AppDelegate (AQYAppdelegate)




-(void)addRoaAnimation:(UIView *)animationView
{
    
  //  [animationView aq_addRotationAnimation:NSIntegerMax andBegainAngle:0 andEndAngel:M_PI*2];
    
    
  
    [UIView animateWithDuration:0.2 animations:^{
        animationView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.70 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
            animationView.layer.transform = CATransform3DMakeRotation(2 * M_PI, 0, 1, 0);
        } completion:nil];
    });
}




//添加抖动动画
- (void)addShakeAnimationOnView:(UIView *)animationView {
    //需要实现的帧动画，这里根据需求自定义
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.rotation";
    CGFloat angle=M_PI*0.05;
    animation.values = @[@(-angle),@(angle),@(-angle)];
    animation.repeatCount=1;
    animation.calculationMode = kCAAnimationCubic;
    [animationView.layer addAnimation:animation forKey:@"shake"];
}

@end
