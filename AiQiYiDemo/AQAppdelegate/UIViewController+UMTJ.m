//
//  UIViewController+UMTJ.m
//  AiQiYiDemo
//
//  Created by ios2 on 2018/9/21.
//  Copyright © 2018年 ios2. All rights reserved.
//

#import "UIViewController+UMTJ.h"
#import <objc/runtime.h>
#import <UMCommon/UMCommon.h>
#import <UMAnalytics/MobClick.h>
@implementation UIViewController (UMTJ)

+(void)load
{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		SEL logDidLoad=@selector(debug_logDidLoad:);

		SEL endDis=@selector(debug_Dismiss:);


		SEL didLoad=@selector(viewWillAppear:);

		SEL endDismiss=@selector(viewWillDisappear:);


		Method logMethod=class_getInstanceMethod (self, logDidLoad);

			//Method  是返回的方法的地址
		Method didLoadMethod=class_getInstanceMethod (self, didLoad);

	 Method logDismiss=class_getInstanceMethod (self, endDis);

	Method dismissMethod=class_getInstanceMethod (self, endDismiss);


		method_exchangeImplementations(didLoadMethod, logMethod);


         method_exchangeImplementations(logDismiss, dismissMethod);


	});
}
-(void)debug_logDidLoad:(BOOL)animation
{
	[self debug_logDidLoad:animation];
	//进入该页面了
	NSString *className = NSStringFromClass(self.class);
	NSString *path =  [[NSBundle mainBundle]pathForResource:@"fileDictionary" ofType:@"plist"];
	NSDictionary *nameDic = nil;
	if (path) {
		nameDic = [NSDictionary dictionaryWithContentsOfFile:path];
	}
	if (nameDic) {
		NSString *name = nameDic[className];
		if (name) {
			className = name;
		}
	}
	if (self.navigationItem.title) {
		className = self.navigationItem.title;
	}
	 [MobClick beginLogPageView:className]; //("Pagename"为页面名称，可自定义)
}
-(void)debug_Dismiss:(BOOL)animation
{
		[self debug_Dismiss:animation];
	NSString *className = NSStringFromClass(self.class);
	NSString *path =  [[NSBundle mainBundle]pathForResource:@"fileDictionary" ofType:@"plist"];
	NSDictionary *nameDic = nil;
	if (path) {
		nameDic = [NSDictionary dictionaryWithContentsOfFile:path];
	}
	if (nameDic) {
		NSString *name = nameDic[className];
		if (name) {
			className = name;
		}
	}
	if (self.navigationItem.title) {
		className = self.navigationItem.title;
	}
	 [MobClick endLogPageView:className];
}



@end
