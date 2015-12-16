//
//  DealLoaclTool.m
//  团购
//
//  Created by tanhui on 15/6/5.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import "DealLoaclTool.h"
#define HISTORYDEALS [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"history.data"]
#define COLLECTIONDEALS [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"collection.data"]

@interface DealLoaclTool()
@property(nonatomic,strong)NSMutableArray* historydeals;
@property(nonatomic,strong)NSMutableArray* collectiondeals;

@end

@implementation DealLoaclTool
SingletonM(LocalTool);
-(NSMutableArray *)historydeals{
    if(!_historydeals){
        _historydeals=[NSKeyedUnarchiver unarchiveObjectWithFile:HISTORYDEALS];
        if(_historydeals.count==0){
            
            _historydeals=[NSMutableArray array];
        }
    }
    return _historydeals;
}

-(void)addHistoryDeal:(Deal*)deal{
    [self.historydeals removeObject:deal];
    [self.historydeals insertObject:deal atIndex:0];
//    [self.historydeals writeToFile:HISTORYDEALS atomically:YES];
    [NSKeyedArchiver archiveRootObject:self.historydeals toFile:HISTORYDEALS];
}
-(void)deleteHistoryArray:(NSArray*)array{
    [[self getHistoryDeals] removeObjectsInArray:array];
    [NSKeyedArchiver archiveRootObject:self.historydeals toFile:HISTORYDEALS];
    
}
-(NSMutableArray*)getHistoryDeals{
    return self.historydeals;
}
-(NSMutableArray*)getCollectionDeals{
    return self.collectiondeals;
}
-(void)deleteCollectionArray:(NSArray*)array{
    [[self getCollectionDeals] removeObjectsInArray:array];
    [NSKeyedArchiver archiveRootObject:self.collectiondeals toFile:COLLECTIONDEALS];

}
-(NSMutableArray *)collectiondeals{
    if(!_collectiondeals){
        _collectiondeals=[NSKeyedUnarchiver unarchiveObjectWithFile:COLLECTIONDEALS];
        if(_collectiondeals.count==0){
            
            _collectiondeals=[NSMutableArray array];
        }
    }
    return _collectiondeals;
}
-(void)addCollectionDeal:(Deal*)deal{
    [self.collectiondeals removeObject:deal];
    [self.collectiondeals addObject:deal];
    [NSKeyedArchiver archiveRootObject:self.collectiondeals toFile:COLLECTIONDEALS];

}
-(void)removeCollectionDeal:(Deal *)deal{
    [self.collectiondeals removeObject:deal];
    [NSKeyedArchiver archiveRootObject:self.collectiondeals toFile:COLLECTIONDEALS];
}
@end
