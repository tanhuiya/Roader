//
//  MetaDataTool.h
//  团购
//
//  Created by tanhui on 15/5/23.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@class City,Sort,MTCategory;
@interface MetaDataTool : NSObject
@property(nonatomic,strong,readonly)NSArray* categories;
@property(nonatomic,strong,readonly)NSArray* sorts;
@property(nonatomic,strong,readonly)NSArray* cities;
@property(nonatomic,strong,readonly)NSArray* cityGroups;

SingletonH(DataTool);
-(Sort*)getLastSort;
-(void)saveSort:(Sort*)sort;
- (void)addCityRecent:(City*)city;
-(City*)getLastCity;
-(City*)getCityWithName:(NSString*)name;
//-(void)saveCategory:(MTCategory*)category;
//-(MTCategory*)getLastCategory;
@end
