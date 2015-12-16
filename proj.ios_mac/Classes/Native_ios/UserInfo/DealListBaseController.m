//
//  DealListBaseController.m
//  团购
//
//  Created by tanhui on 15/6/5.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import "DealListBaseController.h"
#import "DealViewCell.h"
#import "UIBarButtonItem+Extension.h"
#import "DealLoaclTool.h"
#import "Deal.h"
#define EDITE @"编辑"
#define COMELETE @"完成"
@interface DealListBaseController ()<CoverClickDelegate>
@property(nonatomic,strong)UIBarButtonItem* selectAll;
@property(nonatomic,strong)UIBarButtonItem* unselectAll;
@property(nonatomic,strong)UIBarButtonItem* deleteDeals;
@property(nonatomic,strong)UIBarButtonItem* backItem;

@end

@implementation DealListBaseController
-(UIBarButtonItem* )itemWithDict:(UIBarButtonItem*)barItem
{
    NSMutableDictionary* dict=[NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName]=[UIColor blackColor];
    [barItem setTitleTextAttributes:dict forState:UIControlStateNormal];
    
    NSMutableDictionary* dictH=[NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName]=[UIColor lightGrayColor];
    [barItem setTitleTextAttributes:dictH forState:UIControlStateDisabled];
    return barItem;
}
-(UIBarButtonItem *)backItem{
    if (!_backItem) {
        _backItem=[UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"icon_back" highImage:@"icon_back_highlighted"];
    }
    return _backItem;
}

-(UIBarButtonItem *)selectAll{
    if (!_selectAll) {
        _selectAll=[[UIBarButtonItem alloc]initWithTitle:@"   全选  " style:UIBarButtonItemStylePlain target:self action:@selector(selectAllClick:)];
        _selectAll=[self itemWithDict:_selectAll];
    }
    return _selectAll;
}

-(UIBarButtonItem *)unselectAll{
    if (!_unselectAll) {
        _unselectAll=[[UIBarButtonItem alloc]initWithTitle:@"  全不选 " style:UIBarButtonItemStylePlain target:self action:@selector(unselectAllClick:)];
        _unselectAll=[self itemWithDict:_unselectAll];
    }
    return _unselectAll;
}
-(UIBarButtonItem *)deleteDeals{
    if (!_deleteDeals) {
        _deleteDeals=[[UIBarButtonItem alloc]initWithTitle:@"   删除  " style:UIBarButtonItemStylePlain target:self action:@selector(deleteClick:)];
        _deleteDeals=[self itemWithDict:_deleteDeals];
        _deleteDeals.enabled=NO;
    }
    return _deleteDeals;
}
-(void)deleteClick:(UIBarButtonItem*)item{
    
}
-(void)selectAllClick:(UIBarButtonItem*)item{
    for(Deal* deal in self.deals){
        deal.isCheck=YES;
    }
    [self coverDidClicked:nil];
    [self.collectionView reloadData];
}
-(void)unselectAllClick:(UIBarButtonItem*)item{
    for(Deal* deal in self.deals){
        deal.isCheck=NO;
    }
    [self coverDidClicked:nil];
    [self.collectionView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItems=@[self.backItem];
    UIBarButtonItem *rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:EDITE style:UIBarButtonItemStyleDone target:self action:@selector(editingClicked:)];
    self.navigationItem.rightBarButtonItem=[self itemWithDict:rightBarButtonItem];
}
-(void)back{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    for (Deal* deal in self.deals) {
        deal.isEditing=NO;
        deal.isCheck=NO;
    }
    [self.collectionView reloadData];
}
-(void)editingClicked:(UIBarButtonItem*)item{
    if ([item.title isEqual:EDITE]) {
        for (Deal* deal in self.deals) {
            deal.isEditing=YES;
        }
        self.navigationItem.leftBarButtonItems=@[self.backItem,self.selectAll,self.unselectAll,self.deleteDeals];
        [item setTitle:COMELETE];
        
    }else{
        for (Deal* deal in self.deals) {
            deal.isEditing=NO;
            deal.isCheck=NO;
        }
        [item setTitle:EDITE];
        self.navigationItem.leftBarButtonItems=@[self.backItem];
    }
    [self.collectionView reloadData];
}


-(void)coverDidClicked:(UIButton *)cover{
    int num=0;
    for(Deal* deal in self.deals){
        if(deal.isCheck)
            num++;
    }
    if(num>0){
        self.deleteDeals.Enabled=YES;
    }else{
        [self.deleteDeals setEnabled:NO];

    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
