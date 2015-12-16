//
//  DpNetTool.m
//  团购
//
//  Created by tanhui on 15/5/22.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import "DpNetTool.h"
#import "DPAPI.h"
@interface DpNetTool()<DPRequestDelegate>
@property(nonatomic,strong)DPAPI* dp;
@end
@implementation DpNetTool

SingletonM(DP);

-(DPAPI *)dp{
    if(!_dp){
        _dp=[[DPAPI alloc]init];
        
    }
    return _dp;
}


-(void) requestWithURL:(NSString*)url params:(NSMutableDictionary*)dict success:    (void (^)(id result))success error:(void (^)(NSError* error))error{
    DPRequest* requst=[self.dp requestWithURL:url params:dict delegate:self];
    requst.success=success;
    requst.error=error;
    
}
-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result{
    void(^success)(id result)=request.success;
    if(success){
        success(result);
    }
}
-(void)request:(DPRequest *)request didFailWithError:(NSError *)error{
    void(^failure)(NSError* error)=request.error;
    if(failure){
        failure(error);
    }
}
@end
