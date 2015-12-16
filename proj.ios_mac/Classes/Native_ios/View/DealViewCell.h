//
//  DealViewCell.h
//  团购
//
//  Created by tanhui on 15/5/26.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deal.h"

@protocol CoverClickDelegate <NSObject>

@optional
-(void)coverDidClicked:(UIButton*)cover;

@end

@interface DealViewCell : UICollectionViewCell
@property(nonatomic,strong)Deal* deal;
@property(nonatomic,assign)id<CoverClickDelegate>delegate;
@end
