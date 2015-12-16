//
//  MetaDataTool.m
//  团购
//
//  Created by tanhui on 15/5/23.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import "MetaDataTool.h"
#import "MJExtension.h"
#import "MTCategory.h"
#import "City.h"
#import "Region.h"
#import "Sort.h"
#import "CityGroup.h"
#define RECENTCITYNAME [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"recentCityNames.plist"]
#define LASTSORT [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"lastSort.data"]
#define LASTCATEGORY [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"lastCategory.data"]
@interface MetaDataTool()
{
    NSArray *_categories;
    NSArray *_cities;
//    NSMutableArray *_cityGroups;
    NSArray *_sorts;
}
@property(nonatomic,strong)NSMutableArray* recentCitys;
@end
@implementation MetaDataTool

SingletonM(DataTool);
-(NSMutableArray *)recentCitys{
    if(!_recentCitys){
        
        _recentCitys=[NSMutableArray arrayWithContentsOfFile:RECENTCITYNAME];
        if(!_recentCitys){
            _recentCitys=[NSMutableArray array];
        }
    }
    return _recentCitys;
}
- (void)addCityRecent:(City*)city{
    [self.recentCitys removeObject:city.name];
    [self.recentCitys insertObject:city.name atIndex:0];
    [self.recentCitys writeToFile:RECENTCITYNAME atomically:YES];
}
-(City*)getLastCity{
    if(self.recentCitys.count){
        return [self getCityWithName:[self.recentCitys firstObject]];
    }else{
        //todo..
        City *city=[[City alloc]init];
        city.name=@"北京";
        return city;
    }
}
-(City*)getCityWithName:(NSString*)name{
    if (name.length<1) {
        return nil;
    }
    NSArray* array=[self cities];
    for(City * city in array){
        if([city.name isEqualToString:name]){
            return city;
        }
    }
    return nil;
}
-(NSArray *)categories{
    if(!_categories){
        _categories=[MTCategory objectArrayWithFilename:@"categories.plist"];
    }
    return _categories;
}
-(NSArray *)cities{
    if(!_cities){
        _cities=[City objectArrayWithFilename:@"cities.plist"];
    }
    return _cities;
}
-(NSMutableArray *)cityGroups{
    NSMutableArray* totalcityGroups=[NSMutableArray array];

    if(self.recentCitys.count){
        CityGroup* group=[[CityGroup alloc]init];
        group.title=@"最近";
        group.cities=self.recentCitys;
        [totalcityGroups addObject:group];

    }
    NSArray* cityGroups=[CityGroup objectArrayWithFilename:@"cityGroups.plist"];
    [totalcityGroups addObjectsFromArray:cityGroups];
    return totalcityGroups;
}
//-(void)saveCategory:(MTCategory *)category{
//    [NSKeyedArchiver archiveRootObject:category toFile:LASTCATEGORY];
//}
//-(MTCategory *)getLastCategory{
//    return [NSKeyedUnarchiver unarchiveObjectWithFile:LASTCATEGORY];
//}
-(void)saveSort:(Sort*)sort{
    [NSKeyedArchiver archiveRootObject:sort toFile:LASTSORT];
}
-(Sort*)getLastSort{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:LASTSORT];
}
-(NSArray *)sorts{
    if(!_sorts){
        _sorts=[Sort objectArrayWithFilename:@"sorts.plist"];
    }
    return _sorts;
}
@end
