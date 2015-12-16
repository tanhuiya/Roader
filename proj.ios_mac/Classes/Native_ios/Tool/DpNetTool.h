//
//  DpNetTool.h
//  团购
//
//  Created by tanhui on 15/5/22.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"
@interface DpNetTool : NSObject
SingletonH(DP);

-(void) requestWithURL:(NSString*)url params:(NSMutableDictionary*)dict success:    (void (^)(id result))success error:(void (^)(NSError* error))error;
@end
