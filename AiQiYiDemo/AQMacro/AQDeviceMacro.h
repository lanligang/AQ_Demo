//
//  AQDeviceMacro.h
//  AiQiYiDemo
//
//  Created by ios2 on 2017/9/30.
//  Copyright © 2017年 ios2. All rights reserved.
//

#ifndef AQDeviceMacro_h
#define AQDeviceMacro_h

#if __OBJC__

#define KStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

#define KNavBarHeight 44.0

#define KTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)

//iphone x
#define KTopHeight (KStatusBarHeight + KNavBarHeight)



#define scaleX [UIScreen mainScreen].bounds.size.width/375.0f

#define scaleY [UIScreen mainScreen].bounds.size.height/667.0f

//像素转换
#define px(x) x/2.0f

#define px_scale(x) x/2.0f*scaleX


#endif



#endif
