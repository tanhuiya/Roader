//
//  SingleDealResult.h
//  团购
//
//  Created by tanhui on 15/5/23.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleDealResult : NSObject
/** 本次API访问所获取的单页团购数量 */
@property (assign, nonatomic) int count;
/** 所有的团购 */
@property (strong, nonatomic) NSArray *deals;
@end
