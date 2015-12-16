//
//  SearchViewController.h
//  团购
//
//  Created by tanhui on 15/6/6.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import "DealListController.h"
#import "City.h"
@interface SearchViewController : DealListController
@property(nonatomic,strong)City* selectedCity;
@end
