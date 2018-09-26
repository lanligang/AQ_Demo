//
//  AQMacro.h
//  AiQiYiDemo
//
//  Created by ios2 on 2017/9/30.
//  Copyright © 2017年 ios2. All rights reserved.
//

#ifndef AQMacro_h
#define AQMacro_h

#define WS(ws) __weak __typeof(self) ws = self
#define SS(ss) __strong __typeof(ws)ss = ws

#define NullString(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )

#define ST_PULLTOREFRESH_HEADER_HEIGHT  0


#define UM_TJ_APPKEY @"5ba45578b465f57cd000001c"



#endif /* AQMacro_h */
