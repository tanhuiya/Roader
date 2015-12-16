//
//  DealColletionController.m
//  团购
//
//  Created by tanhui on 15/6/5.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import "DealColletionController.h"
#import "DealLoaclTool.h"
#import "Deal.h"
@interface DealColletionController ()

@end

@implementation DealColletionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"我的收藏";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)imageName{
    return @"icon_collects_empty";
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
    [[DealLoaclTool shardWithLocalTool]deleteCollectionArray:deleteArry];
    [self.deals removeObjectsInArray:deleteArry];
    [self.collectionView reloadData];
}

@end
