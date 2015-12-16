//
//  Restrictions.h
//  团购
//
//  Created by tanhui on 15/6/3.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Restrictions : NSObject
/**
 *  是否需要预约，0：不是，1：是
 */
@property(nonatomic,assign)int is_reservation_required;
/**
 *  是否支持随时退款，0：不是，1：是
 */
@property(nonatomic,assign)int is_refundable;
/**
 *  附加信息(一般为团购信息的特别提示)
 */
@property(nonatomic,copy)NSString* special_tips;

@end
