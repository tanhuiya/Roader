//
//  FilterCityController.m
//  团购
//
//  Created by tanhui on 15/5/25.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import "FilterCityController.h"
#import "MetaDataTool.h"
#import "City.h"
#import "notes.h"
@interface FilterCityController ()
@property(nonatomic,strong)NSArray* filterCities;
@end

@implementation FilterCityController
-(void)setSerachText:(NSString *)serachText{
    _serachText=serachText;
    NSArray* cities=[MetaDataTool shardWithDataTool].cities;
    NSString* lowerText=serachText.lowercaseString;
    NSPredicate* predict=[NSPredicate predicateWithFormat:@"name.lowercaseString contains %@ or  pinYin.lowercaseString contains %@ or pinYinHead.lowercaseString contains %@",lowerText,lowerText,lowerText];
    self.filterCities=[cities filteredArrayUsingPredicate:predict];
    [self.tableView reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.filterCities.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    City* city=self.filterCities[indexPath.row];
//    City* city=[[MetaDataTool shardWithDataTool]getCityWithName:name];
    [[NSNotificationCenter defaultCenter]postNotificationName:CitySelectedNotification object:nil userInfo:@{CityParam:city}];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"filterCity"];
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"filterCity"];
    }
    cell.textLabel.text=[self.filterCities[indexPath.row]name];
    
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
