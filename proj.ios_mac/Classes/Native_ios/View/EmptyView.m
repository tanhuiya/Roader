//
//  EmptyView.m
//  团购
//
//  Created by tanhui on 15/6/2.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import "EmptyView.h"
#import "UIView+AutoLayout.h"
@implementation EmptyView
-(instancetype)initWithFrame:(CGRect)frame{
    if([super initWithFrame:frame]){
        self.contentMode=UIViewContentModeCenter;
    }
    return self;
}
-(void)didMoveToSuperview{
    if(self.superview){
        [self autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    }
}


@end
