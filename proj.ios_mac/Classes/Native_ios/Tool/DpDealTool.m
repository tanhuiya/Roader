//
//  DpDealTool.m
//  团购
//
//  Created by tanhui on 15/5/23.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import "DpDealTool.h"
#import "MJExtension.h"
#import "DpNetTool.h"
@implementation DpDealTool
+(void)FindDealsWithParams:(FindDealsParam *)param success:(void (^)(FindDealsReslut *))success error:(void (^)(NSError *error))failure{
    DpNetTool* tool=[DpNetTool shardWithDP];
    [tool requestWithURL:@"v1/deal/find_deals"  params:[param keyValues] success:^(id result) {
        if(success){
            FindDealsReslut* obj=[FindDealsReslut objectWithKeyValues:result];
            success(obj);
        }
    } error:failure];
}
+(void)GetSingleDealWithParams:(SingleDealParam *)param success:(void (^)(SingleDealResult *))success error:(void (^)(NSError *error))failure{
    DpNetTool* tool=[DpNetTool shardWithDP];
    [tool requestWithURL:@"v1/deal/get_single_deal"  params:[param keyValues] success:^(id result) {
        if(success){
            SingleDealResult* obj=[SingleDealResult objectWithKeyValues:result];
            success(obj);
        }
    } error:failure];
}
@end
