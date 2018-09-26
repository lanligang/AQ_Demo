//
//  SaveTool.m
//  SecondApp
//
//  Created by ios2 on 2017/9/22.
//  Copyright © 2017年 ios2. All rights reserved.
//

#import "SaveTool.h"
#define max_count 8
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

@implementation SaveTool

+(BOOL)saveStrToUserDefault:(NSString *)str
{
    if (NullString(str))
    {
        return NO;
    }
    
    NSArray *strs =  [[NSUserDefaults standardUserDefaults]objectForKey:@"historySearch"];
    
    if (strs==nil)
    {
        NSMutableArray *tmpArr = [[NSMutableArray alloc]init];
        [tmpArr addObject:str];
        strs = tmpArr;
    }else{
	  NSInteger indexNum = 0;
	  BOOL isContaint =   [self isContaintString:str from:strs andIndex:&indexNum];
        
	  NSMutableArray *tmpArray = [[NSMutableArray alloc]initWithArray:strs];

        if (isContaint==NO)
        {
		  
            [tmpArray insertObject:str atIndex:0];
            
            if (tmpArray.count>max_count)
            {
                [tmpArray removeObjectAtIndex:max_count];
            }
            
            strs  = [tmpArray copy];
		  }else{
			NSString *string =[NSString stringWithFormat:@"%@",tmpArray[indexNum]];
			[tmpArray removeObjectAtIndex:indexNum];
			[tmpArray insertObject:string atIndex:0];
			strs = [tmpArray copy];
		  }
    }
    [USER_DEFAULT setObject:strs forKey:@"historySearch"];
    
   BOOL isSuccess =  [USER_DEFAULT synchronize];
    
    //存储成功
    return isSuccess;
}

+(BOOL)isContaintString:(NSString *)str from:(NSArray *)array andIndex:(NSInteger *)index
{
     NSInteger num = 0;
    for (NSString *aStr in array)
    {
	 
        if ([aStr isEqualToString:str])
        {
		  *index = num;
            return YES;
            break;
        }
	    num++;
    }
    return NO;
}

//移除掉所有的
+(BOOL)removeAllHistory
{
    [USER_DEFAULT removeObjectForKey:@"historySearch"];
    
    BOOL isSuccess = [USER_DEFAULT synchronize];
    
    return isSuccess;
}

+(NSArray *)findHistorySearch
{
     NSArray *strs =  [[NSUserDefaults standardUserDefaults]objectForKey:@"historySearch"];
    if (strs) {
        return strs;
    }
    return @[];
}


@end

