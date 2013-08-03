//
//  Consts.h
//  listWork
//
//  Created by 徐 哲 on 13-7-19.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#ifdef DEBUG
#define debugLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define debugLog(...)
#define debugMethod()
#endif
