//
//  UIView+AQanimation.m
//  AiQiYiDemo
//
//  Created by ios2 on 2017/10/11.
//  Copyright © 2017年 ios2. All rights reserved.
//

#import "UIView+AQanimation.h"

@implementation UIView (AQanimation)

-(void)aq_addRoaAnimation
{
    [UIView animateWithDuration:0.2 animations:^{
        self.layer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.70 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.layer.transform = CATransform3DMakeRotation(2 * M_PI, 0, 0, 1);
        } completion:nil];
    });
}

- (void)aq_addShakeAnimation
{
    CGFloat angle=M_PI*0.05;
    [self aq_addShakeAnimation:1 andAngle:angle];
}
- (void)aq_addShakeAnimation:(NSInteger)repeatCount andAngle:(CGFloat)angle
{
    //需要实现的帧动画，这里根据需求自定义
    [self.layer removeAnimationForKey:@"shake"];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.rotation";
    
    animation.values = @[@(-angle),@(angle),@(-angle)];
    animation.repeatCount = repeatCount;
    animation.calculationMode = kCAAnimationCubic;
    [self.layer addAnimation:animation forKey:@"shake"];
}

-(void)aq_addScaleAnimation:(CGFloat)scale
{
    [self.layer removeAnimationForKey:@"scale"];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    
    animation.values = @[@(scale),@(1),@(scale),@(1)];
    animation.duration = 0.3;
    animation.calculationMode = kCAAnimationCubic;
    [self.layer addAnimation:animation forKey:@"scale"];
}


-(void)aq_addRotationAnimation:(NSInteger)repeatCount andBegainAngle:(CGFloat)begainAngle andEndAngel:(CGFloat)endAngel
{
    [self.layer removeAnimationForKey:@"rotation"];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.rotation";
    
    animation.values = @[@(begainAngle),@(endAngel)];
    animation.repeatCount = repeatCount;
    animation.speed = 1;
    animation.duration = 1;
    animation.calculationMode = kCAAnimationCubic;
    [self.layer addAnimation:animation forKey:@"rotation"];
}



@end
