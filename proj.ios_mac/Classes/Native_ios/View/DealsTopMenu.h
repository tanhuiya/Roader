//
//  DealsTopMenu.h
//  团购
//
//  Created by tanhui on 15/5/23.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealsTopMenu : UIView
+(instancetype)menu;

@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (weak, nonatomic) IBOutlet UILabel *SubTitle;

-(void)addTarget:(id)target selector:(SEL)sel;
@end
