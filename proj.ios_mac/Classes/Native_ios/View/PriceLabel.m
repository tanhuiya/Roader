//
//  PriceLabel.m
//  团购
//
//  Created by tanhui on 15/6/2.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import "PriceLabel.h"

@implementation PriceLabel


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    [self.textColor set];
    UIRectFill(CGRectMake(0, self.frame.size.height*0.5, self.frame.size.width, 0.5));
    
}


@end
