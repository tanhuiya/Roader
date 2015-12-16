//
//  Region.m
//  团购
//
//  Created by tanhui on 15/5/23.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import "Region.h"

@implementation Region

-(NSString *)title{
    return self.name;
}
-(NSArray *)subTitle{
    return self.subregions;
}
@end
