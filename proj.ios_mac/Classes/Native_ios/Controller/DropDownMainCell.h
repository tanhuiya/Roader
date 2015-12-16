//
//  DropDownMainCell.h
//  团购
//
//  Created by tanhui on 15/5/24.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownMenu.h"

@interface DropDownMainCell : UITableViewCell
+(instancetype)cellwithTableView:(UITableView*)tableView;

@property(nonatomic,strong)id<DropDownMenuItemDelegate>item;
@end
