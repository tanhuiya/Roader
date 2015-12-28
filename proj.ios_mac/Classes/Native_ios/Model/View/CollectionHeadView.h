//
//  CollectionHeadView.h
//  DianPing
//
//  Created by tanhui on 15/12/13.
//  Copyright © 2015年 tanhui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MTCategory;
@protocol CateGoryButtonDelegate <NSObject>

-(void)cateGoryDidselect:(MTCategory*)category;

@end

@interface CollectionHeadView : UICollectionReusableView
@property(nonatomic,assign)id<CateGoryButtonDelegate> btnDelegate;
@property(nonatomic,strong)NSArray* categories;
@end
