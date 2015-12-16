//
//  Singleton.h
//  团购
//
//  Created by tanhui on 15/5/22.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#define SingletonH(name) +(instancetype)shardWith##name

#define SingletonM(name)\
static id _instance;\
+(instancetype)allocWithZone:(struct _NSZone *)zone{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        _instance=[super allocWithZone:zone];\
    });\
    return _instance;\
}\
+(instancetype)shardWith##name{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        _instance=[[self alloc]init];\
    });\
    return _instance;\
}