//
//  SaveTool.h
//  SecondApp
//
//  Created by ios2 on 2017/9/22.
//  Copyright © 2017年 ios2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveTool : NSObject

+(BOOL)saveStrToUserDefault:(NSString *)str;

+(BOOL)removeAllHistory;



+(NSArray *)findHistorySearch;


@end
