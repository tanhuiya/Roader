//
//  DropDownMenu.m
//  团购
//
//  Created by tanhui on 15/5/24.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import "DropDownMenu.h"
#import "DropDownSubCell.h"
#import "DropDownMainCell.h"

@interface DropDownMenu()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mainTableview;
@property (weak, nonatomic) IBOutlet UITableView *subTableview;

@end
@implementation DropDownMenu
+(instancetype)Dropmenu{
    return [[[NSBundle mainBundle]loadNibNamed:@"DropDownMenu" owner:nil options:nil]lastObject];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView==self.mainTableview){
        return self.items.count;
    }else{
        int mainRow=[self.mainTableview indexPathForSelectedRow].row;
//        id<DropDownMenuItemDelegate>item=self.items[mainRow];
        return [self.items[mainRow] subTitle].count;
    }
    
}
-(void)setItems:(NSArray *)items{
    _items=items;
    
    [self.mainTableview reloadData];
    [self.subTableview reloadData];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView==self.mainTableview){
        [self.subTableview reloadData];
        if([self.delegate respondsToSelector:@selector(clickWithMainIndex:)]){
            int mainRow=(int)indexPath.row;
            [self.delegate clickWithMainIndex:mainRow];
        }
    }else{
        if([self.delegate respondsToSelector:@selector(clickWithMainIndex:)]){
            int mainRow=(int)[self.mainTableview indexPathForSelectedRow].row;
            [self.delegate clickWithMainIndex:mainRow andSubIndex:(int)indexPath.row];
        }
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView==self.mainTableview){
        DropDownMainCell* cell=[DropDownMainCell cellwithTableView:tableView];
        cell.item=self.items[indexPath.row];
        return cell;
    }else{
        DropDownSubCell* cell=[DropDownSubCell cellwithTableView:tableView];
        int mainRow=(int)[self.mainTableview indexPathForSelectedRow].row;
        id<DropDownMenuItemDelegate>item=self.items[mainRow];
        cell.textLabel.text=[item subTitle][indexPath.row];
//        cell.textLabel.text=@"1231";
        return cell;
    }
    
}
-(void)setMainRow:(int)mainRow{
    [self.mainTableview selectRowAtIndexPath:[NSIndexPath indexPathForRow:mainRow inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self.subTableview reloadData];
}
-(void)setSubRow:(int)subRow{
    [self.subTableview selectRowAtIndexPath:[NSIndexPath indexPathForRow:subRow inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
}
@end
