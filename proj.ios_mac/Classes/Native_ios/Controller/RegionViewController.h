//
//  CityViewController.h
//  团购
//
//  Created by tanhui on 15/5/24.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class City,Region;
@interface RegionViewController : UIViewController
@property(nonatomic,strong)City* city;
@property(nonatomic,strong)void(^changeCityBlock)();

@property(nonatomic,strong)Region* selectedRegion;
@property(nonatomic,copy)NSString* selectedSubRegion;

@end
