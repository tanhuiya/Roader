//
//  Category.m
//  团购
//
//  Created by tanhui on 15/5/23.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import "MTCategory.h"
#import "MJExtension.h"
@implementation MTCategory
-(NSString *)title{
    return self.name;
}
-(NSArray *)subTitle{
    return self.subcategories;
}
-(NSString *)small_image{
    return self.small_icon;
}
-(NSString *)small_image_highlight{
    return self.small_highlighted_icon;
}
-(BOOL)isEqual:(MTCategory*)object{
    return [self.name isEqualToString:object.name];
}
MJCodingImplementation
@end
