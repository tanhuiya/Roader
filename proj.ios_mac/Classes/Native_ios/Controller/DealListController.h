//
//  DealListController.h
//  团购
//
//  Created by tanhui on 15/6/5.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealListController : UICollectionViewController
@property(nonatomic,strong)NSMutableArray* deals;
-(NSString*)imageName;
@end
