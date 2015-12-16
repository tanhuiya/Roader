//
//  CateroryBtn.m
//  DianPing
//
//  Created by tanhui on 15/12/13.
//  Copyright © 2015年 tanhui. All rights reserved.
//

#import "CateroryBtn.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation CateroryBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self setBackgroundColor:[self randomColor]];
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        [self setTitleColor:[UIColor colorWithRed:45/255.0 green:45/255.0 blue:45/255.0 alpha:1.0] forState:UIControlStateNormal];
        self.titleLabel.font=[UIFont systemFontOfSize:12];
        self.imageView.contentMode=UIViewContentModeScaleAspectFit;
        [self setContentMode:UIViewContentModeScaleAspectFit];
    }
    return self;
}
-(CGRect)contentRectForBounds:(CGRect)bounds{
    return bounds;
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake((contentRect.size.width-50)*0.5, 5, 50, 52);
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, 60, contentRect.size.width, contentRect.size.height-60);
}
-(UIColor *)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
-(void)setCategory:(MTCategory *)category{
    _category=category;
    [self setTitle:category.name forState:UIControlStateNormal];
    self.imageView.image=[UIImage imageNamed:category.circle];
    [self setImage:[UIImage imageNamed:category.circle] forState:UIControlStateNormal];
}
@end
