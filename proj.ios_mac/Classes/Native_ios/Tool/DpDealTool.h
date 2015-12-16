//
//  DpDealTool.h
//  团购
//
//  Created by tanhui on 15/5/23.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FindDealsParam.h"
#import "FindDealsReslut.h"
#import "SingleDealParam.h"
#import "SingleDealResult.h"
@interface DpDealTool : NSObject
+(void)FindDealsWithParams:(FindDealsParam*)param success:(void (^)(FindDealsReslut* result))success error:(void (^)(NSError* error))failure;

+(void)GetSingleDealWithParams:(SingleDealParam*)param success:(void (^)(SingleDealResult* result))success error:(void (^)(NSError* error))failure;
@end
