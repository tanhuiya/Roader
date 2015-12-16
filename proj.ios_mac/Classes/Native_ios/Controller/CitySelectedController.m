//
//  CitySelectedController.m
//  团购
//
//  Created by tanhui on 15/5/24.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import "CitySelectedController.h"
#import "MetaDataTool.h"
#import "FilterCityController.h"
#import "UIView+AutoLayout.h"
#import "notes.h"
@interface CitySelectedController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
- (IBAction)closeButtonClick:(id)sender;
@property (weak, nonatomic) IBOutlet UISearchBar *serchBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) IBOutlet UIButton *cover;
@property(strong ,nonatomic)FilterCityController* filterCityVC;
@property(strong,nonatomic)NSArray* cityGroups;
@end

@implementation CitySelectedController
-(FilterCityController *)filterCityVC{
    if(!_filterCityVC){
        _filterCityVC=[[FilterCityController alloc]init];
        
    }
    return  _filterCityVC;
}

-(NSArray *)cityGroups{
    if(!_cityGroups){
        _cityGroups=[MetaDataTool shardWithDataTool].cityGroups;
    }
    return _cityGroups;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES  animated: YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewController:self.filterCityVC];
    // Do any additional setup after loading the view from its nib.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray* arr=[self.cityGroups[section] cities];
    return arr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  self.cityGroups.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.cityGroups[section] title];
}
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return [self.cityGroups valueForKeyPath:@"title"];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* ID=@"citycell";
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    NSArray* cities=[self.cityGroups[indexPath.section] cities];
    cell.textLabel.text=cities[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray* cities=[self.cityGroups[indexPath.section] cities];
    NSString* cityname=cities[indexPath.row];
    City* city=[[MetaDataTool shardWithDataTool] getCityWithName:cityname];
    [[NSNotificationCenter defaultCenter]postNotificationName:CitySelectedNotification object:nil userInfo:@{CityParam:city}];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [searchBar setBackgroundImage:[UIImage imageNamed:@"bg_login_textfield_hl"]];
    [searchBar setShowsCancelButton:YES animated:YES];
    self.topConstraint.constant=-62;
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
        self.cover.alpha=0.5;
    }];
    
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self.filterCityVC.view removeFromSuperview];
    if(searchText.length>0){
        [self.view addSubview:self.filterCityVC.view];
        [self.filterCityVC.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [self.filterCityVC.view autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:searchBar];
        self.filterCityVC.serachText=searchText;
    }
    
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [searchBar setBackgroundImage:[UIImage imageNamed:@"bg_login_textfield"]];
    [searchBar setShowsCancelButton:NO animated:YES];
    self.topConstraint.constant=0;
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
        self.cover.alpha=0.0;
    }];
    searchBar.text=nil;
    [self.filterCityVC.view removeFromSuperview];
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar endEditing:YES];
}



- (IBAction)closeButtonClick:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
