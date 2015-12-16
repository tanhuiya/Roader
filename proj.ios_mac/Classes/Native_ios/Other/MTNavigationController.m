//
//  MTNavigationController.m
//  团购
//
//  Created by tanhui on 15/5/23.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import "MTNavigationController.h"

@implementation MTNavigationController

+(void)initialize{
    UINavigationBar* bar=[UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"bg_navigationBar_normal"] forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem* barItem=[UIBarButtonItem appearance];
    
    NSMutableDictionary* dict=[NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName]=[UIColor blackColor];
    [barItem setTitleTextAttributes:dict forState:UIControlStateNormal];
    
    NSMutableDictionary* dictH=[NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName]=[UIColor grayColor];
    [barItem setTitleTextAttributes:dictH forState:UIControlStateDisabled];
}
//-(NSUInteger)supportedInterfaceOrientations{
//    return UIInterfaceOrientationMaskLandscape;
//}
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight||interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
//    
//}
@end
