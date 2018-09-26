//
//  AppDelegate.m
//  AiQiYiDemo
//
//  Created by ios2 on 2017/9/30.
//  Copyright © 2017年 ios2. All rights reserved.
//

#import "AppDelegate.h"

#import "CYLTabBarControllerConfig.h"
#import "CYLPlusButtonSubclass.h"

#import "AppDelegate+AQYAppdelegate.h"
#import <UMCommon/UMCommon.h>
#import <UMAnalytics/DplusMobClick.h>

@interface AppDelegate ()<UITabBarControllerDelegate, CYLTabBarControllerDelegate>


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc]init];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    [CYLPlusButtonSubclass registerPlusButton];
 
    CYLTabBarControllerConfig *tabBarControllerConfig = [[CYLTabBarControllerConfig alloc] init];
    CYLTabBarController *tabBarController = tabBarControllerConfig.tabBarController;
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:tabBarController];
    nav.navigationBarHidden = YES;
    
    [self.window setRootViewController:nav];
    tabBarController.delegate = self;
    [self.window makeKeyAndVisible];
#if DEBUG
		[UMConfigure initWithAppkey:UM_TJ_APPKEY channel:@"Debug"];
#else
		[UMConfigure initWithAppkey:UM_TJ_APPKEY channel:nil];
#endif

	[UMConfigure setEncryptEnabled:YES];

    return YES;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    [[self cyl_tabBarController] updateSelectionStatusIfNeededForTabBarController:tabBarController shouldSelectViewController:viewController];
    return YES;
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectControl:(UIControl *)control {
    
    UIView *animationView;
    if ([control isKindOfClass:[CYLExternPlusButton class]]) {
        UIButton *button = CYLExternPlusButton;
        animationView = button.imageView;
        [self addShakeAnimationOnView:animationView];
        return;
    } else if ([control isKindOfClass:NSClassFromString(@"UITabBarButton")])
    {
        for (UIView *subView in control.subviews) {
            if ([subView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")])
            {
                animationView = subView;
            }
        }
    }
    if (tabBarController.selectedIndex==0)
    {
        [self addRoaAnimation:animationView];
    }else{
        [animationView aq_addScaleAnimation:1.2];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
