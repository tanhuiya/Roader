//
//  Deal.m
//  团购
//
//  Created by tanhui on 15/5/23.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import "Deal.h"
#import "MJExtension.h"
#import "Business.h"
@implementation Deal
-(NSDictionary *)objectClassInArray{
    return @{@"businesses":[Business class]};
}
-(NSDictionary *)replacedKeyFromPropertyName{
    return @{@"desc":@"description"};
}
-(BOOL)isEqual:(id)object{
    return [self.deal_id isEqual:[object deal_id]];
}
-(NSNumber*)dealNumber:(NSNumber*)source{
    NSString* str=[source description];
    NSUInteger doIndex=[str rangeOfString:@"."].location;
    if(doIndex!=NSNotFound && str.length-doIndex>2){
        str=[str substringToIndex:doIndex+3];
    }
    NSNumberFormatter* fomatter=[[NSNumberFormatter alloc]init];
    return [fomatter numberFromString:str];
}
-(void)setCurrent_price:(NSNumber *)current_price{
    _current_price=[self dealNumber:current_price];
}
-(void)setList_price:(NSNumber *)list_price{
    _list_price=[self dealNumber:list_price];

}
MJCodingImplementation
@end
