//
//  CYLPlusButtonSubclass.m
//  CYLTabBarControllerDemo
//
//  v1.14.0 Created by 微博@iOS程序犭袁 ( http://weibo.com/luohanchenyilong/ ) on 15/10/24.
//  Copyright (c) 2015年 https://github.com/ChenYilong . All rights reserved.
//

#import "CYLPlusButtonSubclass.h"
#import "CYLTabBarController.h"
#import "UIView+SnailUse.h"
#import "AQPlussPushViewController.h"


@interface CYLPlusButtonSubclass ()<SnailFullScreenViewDelegate> {
    CGFloat _buttonImageHeight;
}

@end

@implementation CYLPlusButtonSubclass

#pragma mark -
#pragma mark - Life Cycle

+ (void)load {
    //请在 `-application:didFinishLaunchingWithOptions:` 中进行注册，否则iOS10系统下存在Crash风险。
    //[super registerPlusButton];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

//上下结构的 button
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 控件大小,间距大小
    // 注意：一定要根据项目中的图片去调整下面的0.7和0.9，Demo之所以这么设置，因为demo中的 plusButton 的 icon 不是正方形。
    
    CGFloat const imageViewEdgeWidth   = self.bounds.size.width * 0.7;
    CGFloat const imageViewEdgeHeight  = imageViewEdgeWidth * 0.9;
    
    CGFloat const centerOfView    = self.bounds.size.width * 0.5;
    CGFloat const labelLineHeight = self.titleLabel.font.lineHeight;
    
    CGFloat const verticalMargin  = (self.bounds.size.height - labelLineHeight - imageViewEdgeHeight) * 0.5;
    
    // imageView 和 titleLabel 中心的 Y 值
    CGFloat const centerOfImageView  = verticalMargin + imageViewEdgeHeight * 0.5;
    
    CGFloat const centerOfTitleLabel = imageViewEdgeHeight  + verticalMargin * 2 + labelLineHeight * 0.5 +12.0f;
    
    //imageView position 位置
    self.imageView.bounds = CGRectMake(0, 0, imageViewEdgeWidth, imageViewEdgeHeight);
    
    self.imageView.center = CGPointMake(centerOfView, centerOfImageView+5.0f);
    
    //title position 位置
    self.titleLabel.bounds = CGRectMake(0, 0, self.bounds.size.width, labelLineHeight);
    self.titleLabel.center = CGPointMake(centerOfView, centerOfTitleLabel);
}

#pragma mark -
#pragma mark - CYLPlusButtonSubclassing Methods


+ (id)plusButton {
    CYLPlusButtonSubclass *button = [[CYLPlusButtonSubclass alloc] init];
    UIImage *buttonImage = [UIImage imageNamed:@"tab_add"];
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button setTitle:@"发布" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
 
    [button setTitle:@"发布" forState:UIControlStateSelected];
    
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];

    button.titleLabel.font = [UIFont systemFontOfSize:11.0f];
    
    [button sizeToFit];
    
    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    return button;
}
#pragma mark - Event Response

- (void)clickPublish
{
//点击中间大按钮
    SnailFullScreenView *v = [UIView fullScreen];
    v.delegate = self;
    _popups = [SnailQuickMaskPopups popupsWithMaskStyle:MaskStyleClear aView:v];
    _popups.isDismissedOppositeDirection = YES;
    _popups.isAllowPopupsDrag = NO;
    [_popups presentAnimated:YES completion:NULL];

}
// 点击了空白
- (void)fullScreenViewWhenTapped:(SnailFullScreenView *)fullScreenView
{
 [self dismiss];
}

- (void)fullScreenViewDidClickAdvertisement:(UIButton *)advertisement
{
    
}
// 点击了每个item
- (void)fullScreenView:(SnailFullScreenView *)fullView didClickItemAtIndex:(NSInteger)index
{
     [self dismiss];
 
 UIWindow *window = [[UIApplication sharedApplication].delegate window];
 UINavigationController *nav = (UINavigationController *)window.rootViewController;
 AQPlussPushViewController *vc = [[AQPlussPushViewController alloc]init];
 vc.index = index;
 [nav pushViewController:vc animated:YES];

}



- (void)dismiss
{
    [_popups dismissAnimated:YES completion:NULL];
    [self addShakeAnimationOnView:self.imageView];
}



+ (CGFloat)multiplierOfTabBarHeight:(CGFloat)tabBarHeight {
    return  0.3;
}

+ (CGFloat)constantOfPlusButtonCenterYOffsetForTabBarHeight:(CGFloat)tabBarHeight {
    return  -10;
}
- (void)addShakeAnimationOnView:(UIView *)animationView {
    //需要实现的帧动画，这里根据需求自定义
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.rotation";
    CGFloat angle=M_PI*0.05;
    animation.values = @[@(-angle),@(angle),@(-angle)];
    animation.repeatCount=2;
    animation.calculationMode = kCAAnimationCubic;
    [animationView.layer addAnimation:animation forKey:@"shake"];
}


@end
