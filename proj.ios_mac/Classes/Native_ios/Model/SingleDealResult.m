//
//  SingleDealResult.m
//  团购
//
//  Created by tanhui on 15/5/23.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import "SingleDealResult.h"
#import "MJExtension.h"
#import "Deal.h"
@implementation SingleDealResult
-(NSDictionary *)objectClassInArray{
    return @{@"deals":[Deal class]};
}
@end
