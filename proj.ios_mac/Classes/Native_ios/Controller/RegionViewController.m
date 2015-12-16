//
//  CityViewController.m
//  团购
//
//  Created by tanhui on 15/5/24.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import "RegionViewController.h"
#import "DropDownMenu.h"
#import "UIView+AutoLayout.h"
#import "CitySelectedController.h"
#import "MetaDataTool.h"
#import "City.h"
#import "Region.h"
#import "notes.h"
@interface RegionViewController ()<DropDownNoteDelegate>
- (IBAction)changeCity:(id)sender;
@property(nonatomic,strong)DropDownMenu* dropmenu;
@end

@implementation RegionViewController
-(DropDownMenu *)dropmenu{
    if(!_dropmenu){
        _dropmenu=[DropDownMenu Dropmenu];
    }
    return _dropmenu;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.dropmenu.delegate=self;
    
    UIView* topview=self.view.subviews.firstObject;
    [self.view addSubview:self.dropmenu];
    [self.dropmenu autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.dropmenu autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:topview];
    
//    MetaDataTool* tool=[MetaDataTool shardWithDataTool];
//    City* city=[tool getCityWithName:@"南京"];
    NSArray* subRegion=self.city.regions;
    _dropmenu.items=subRegion;
//    self.preferredContentSize=CGSizeMake(400, 400);
}
-(void)setCity:(City *)city{
    _city=city;
    self.dropmenu.items=city.regions;
    
}

- (IBAction)changeCity:(id)sender {
//    if(self.changeCityBlock){
//        self.changeCityBlock();
//    }
//    UIPopoverController* pop=[self valueForKeyPath:@"popoverController"];
//    [pop dismissPopoverAnimated:YES];
    
    CitySelectedController* city=[[CitySelectedController alloc]init];
//    city.modalPresentationStyle=UIModalPresentationFormSheet;
//    [self presentViewController:city animated:YES completion:nil];
    [self.navigationController pushViewController:city animated:NO];
}

#pragma mark -DropDownNoteDelegate
-(void)clickWithMainIndex:(int)mainIndex{
    Region* region=self.dropmenu.items[mainIndex];
    NSArray* regions=region.subregions;
    if(regions.count==0){
        [[NSNotificationCenter defaultCenter]postNotificationName:RegionSelectedNotification object:nil userInfo:@{RegionParam:region}];
//        [self dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)clickWithMainIndex:(int)mainIndex andSubIndex:(int)subIndex{
    NSMutableDictionary* dict=[NSMutableDictionary dictionary];
    Region* region=self.dropmenu.items[mainIndex];
    NSArray* regions=region.subregions;
    NSString* subRe=regions[subIndex];
    dict[RegionParam]=region;
    dict[SubRegionParam]=subRe;
    [[NSNotificationCenter defaultCenter]postNotificationName:RegionSelectedNotification object:nil userInfo:dict];
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setSelectedRegion:(Region *)selectedRegion{
    if(!selectedRegion)
        return;
    _selectedRegion=selectedRegion;
    int mainRow=(int)[self.dropmenu.items indexOfObject:selectedRegion];
    [self.dropmenu setMainRow:mainRow];
}
-(void)setSelectedSubRegion:(NSString *)selectedSubRegion{
    if(!selectedSubRegion){
        return;
    }
    _selectedSubRegion=selectedSubRegion;
    int subRow=(int)[self.selectedRegion.subregions indexOfObject:selectedSubRegion];
    [self.dropmenu setSubRow:subRow];
}
@end








