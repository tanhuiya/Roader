//
//  DropDownSubCell.m
//  团购
//
//  Created by tanhui on 15/5/24.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import "DropDownSubCell.h"

@implementation DropDownSubCell


+(instancetype)cellwithTableView:(UITableView*)tableView{
    static NSString* subID=@"subcell";
    DropDownSubCell* cell=[tableView dequeueReusableCellWithIdentifier:subID ];
    if(!cell){
        cell=[[DropDownSubCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:subID];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if([super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setBackgroundView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dropdown_rightpart"]]];
        [self setSelectedBackgroundView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dropdown_right_selected"]]];
    }
    return self;
}

@end
