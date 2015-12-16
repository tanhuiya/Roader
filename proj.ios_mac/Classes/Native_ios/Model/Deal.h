//
//  Deal.h
//  团购
//
//  Created by tanhui on 15/5/23.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Restrictions.h"
@interface Deal : NSObject
/** 团购单ID */
@property (copy, nonatomic) NSString *deal_id;
/** 团购标题 */
@property (copy, nonatomic) NSString *title;
/** 团购描述 */
@property (copy, nonatomic) NSString *desc;

/** 城市名称，city为＂全国＂表示全国单，其他为本地单 */
@property (copy, nonatomic) NSString *city;

/** 团购包含商品原价值 */
@property (strong, nonatomic) NSNumber* list_price;
/** 团购价格 */
@property (strong, nonatomic) NSNumber* current_price;

/**  团购适用商户所在行政区 NSString */
@property (strong, nonatomic) NSArray *regions;
/**  团购所属分类 NSString */
@property (strong, nonatomic) NSArray *categories;

/** 团购当前已购买数 */
@property (assign, nonatomic) int purchase_count;

/** 团购发布上线日期 */
@property (copy, nonatomic) NSString *publish_date;
/** 团购单的截止购买日期 */
@property (copy, nonatomic) NSString *purchase_deadline;

/** 团购图片链接，最大图片尺寸450×280 */
@property (copy, nonatomic) NSString *image_url;
@property (copy, nonatomic) NSArray *more_image_urls;

/** 小尺寸团购图片链接，最大图片尺寸160×100 */
@property (copy, nonatomic) NSString *s_image_url;
@property (copy, nonatomic) NSArray *more_s_image_urls;

/** 团购Web页面链接，适用于网页应用 */
@property (copy, nonatomic) NSString *deal_url;
/** 团购HTML5页面链接，适用于移动应用和联网车载应用 */
@property (copy, nonatomic) NSString *deal_h5_url;
@property (strong, nonatomic) Restrictions *restrictions;

/** 团购所适用的商户列表 */
@property (strong, nonatomic) NSArray *businesses;

/** 团购详情 */
@property (copy, nonatomic) NSString *details;
/** 重要通知(一般为团购信息的临时变更) */
@property (copy, nonatomic) NSString *notice;

@property(assign,nonatomic)BOOL isCheck;
@property(assign,nonatomic)BOOL isEditing;
@end
