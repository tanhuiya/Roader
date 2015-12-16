//
//  DealLoaclTool.h
//  团购
//
//  Created by tanhui on 15/6/5.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@class Deal;
@interface DealLoaclTool : NSObject
-(void)addHistoryDeal:(Deal*)deal;
-(NSMutableArray*)getHistoryDeals;
-(NSMutableArray*)getCollectionDeals;
-(void)addCollectionDeal:(Deal*)deal;
-(void)removeCollectionDeal:(Deal*)deal;
-(void)deleteCollectionArray:(NSArray*)array;
-(void)deleteHistoryArray:(NSArray*)array;

SingletonH(LocalTool);
@end
