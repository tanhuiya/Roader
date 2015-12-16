//
//  DealsTopMenu.m
//  团购
//
//  Created by tanhui on 15/5/23.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import "DealsTopMenu.h"

@interface DealsTopMenu()


@end
@implementation DealsTopMenu
+(instancetype)menu{
    return [[[NSBundle mainBundle]loadNibNamed:@"DealsTopMenu" owner:nil options:nil]lastObject];
}
-(void)addTarget:(id)target selector:(SEL)sel{
    [self.imageButton addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
}
@end
