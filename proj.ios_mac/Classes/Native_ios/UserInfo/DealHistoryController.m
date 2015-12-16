//
//  DealHistoryController.m
//  团购
//
//  Created by tanhui on 15/6/5.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import "DealHistoryController.h"
#import "UIBarButtonItem+Extension.h"
#import "DealLoaclTool.h"
#import "Deal.h"
@interface DealHistoryController ()

@end

@implementation DealHistoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"浏览记录";

}
-(NSString *)imageName{
    return @"icon_latestBrowse_empty";
}

-(void)deleteClick:(UIBarButtonItem*)item{
    NSMutableArray* deleteArry=[NSMutableArray array];
    for(Deal* deal in self.deals){
        if(deal.isCheck){
            deal.isEditing=NO;
            deal.isCheck=NO;
            [deleteArry addObject:deal];
        }
    }
    [[DealLoaclTool shardWithLocalTool]deleteHistoryArray:deleteArry];
    [self.deals removeObjectsInArray:deleteArry];
    [self.collectionView reloadData];
}
@end
