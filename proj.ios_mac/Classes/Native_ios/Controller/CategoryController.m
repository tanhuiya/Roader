//
//  CategoryControllerViewController.m
//  团购
//
//  Created by tanhui on 15/5/24.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import "CategoryController.h"
#import "DropDownMenu.h"
#import "MetaDataTool.h"
#import "MTCategory.h"
#import "notes.h"
@interface CategoryController ()<DropDownNoteDelegate>
@property(nonatomic,weak)DropDownMenu* dropMenu;
@end

@implementation CategoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DropDownMenu* dropMenu=[DropDownMenu Dropmenu];
    self.dropMenu=dropMenu;
    dropMenu.delegate=self;
    self.view =dropMenu;
    self.preferredContentSize=CGSizeMake(400, 400);
    dropMenu.items=[MetaDataTool shardWithDataTool].categories;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)clickWithMainIndex:(int)mainIndex{
    NSArray* cates=[MetaDataTool shardWithDataTool].categories;
    if([cates[mainIndex] subcategories].count==0){
        [[NSNotificationCenter defaultCenter]postNotificationName:CategorySelectedNotification object:nil userInfo:@{CategoryParam:cates[mainIndex]}];
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)clickWithMainIndex:(int)mainIndex andSubIndex:(int)subIndex{
    NSArray* cates=[MetaDataTool shardWithDataTool].categories;
    NSMutableDictionary* dict=[NSMutableDictionary dictionary];
    MTCategory* cate=cates[mainIndex];
    dict[CategoryParam]=cate;
    dict[CategorySubParam]=cate.subcategories[subIndex];

    [[NSNotificationCenter defaultCenter]postNotificationName:CategorySelectedNotification object:nil userInfo:dict];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setSelectedCategory:(MTCategory *)selectedCategory{
    if(!selectedCategory)
        return;
    _selectedCategory=selectedCategory;
    int mainRow=(int)[self.dropMenu.items indexOfObject:selectedCategory];
    [self.dropMenu setMainRow:mainRow];
}
-(void)setSelectedSubCategory:(NSString *)selectedSubCategory{
    if(!selectedSubCategory)
        return;
    _selectedSubCategory=selectedSubCategory;
    int subRow=(int)[self.selectedCategory.subcategories indexOfObject:selectedSubCategory];
    [self.dropMenu setSubRow:subRow];
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
