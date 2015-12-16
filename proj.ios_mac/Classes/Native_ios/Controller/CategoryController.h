//
//  CategoryControllerViewController.h
//  团购
//
//  Created by tanhui on 15/5/24.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  MTCategory;
@interface CategoryController : UIViewController
@property(nonatomic,strong)MTCategory* selectedCategory;
@property(nonatomic,copy)NSString* selectedSubCategory;

@end
