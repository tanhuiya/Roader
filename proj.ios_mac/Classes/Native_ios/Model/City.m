//
//  City.m
//  团购
//
//  Created by tanhui on 15/5/23.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import "City.h"
#import "Region.h"
#import "MJExtension.h"
@implementation City
-(NSDictionary *)objectClassInArray{
    return @{@"regions":[Region class]};
}
@end
