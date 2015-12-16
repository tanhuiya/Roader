//
//  DropDownMainCell.m
//  团购
//
//  Created by tanhui on 15/5/24.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import "DropDownMainCell.h"

@interface DropDownMainCell()
@property(strong,nonatomic)UIImageView* accessView;

@end

@implementation DropDownMainCell
-(UIImageView *)accessView{
    if(!_accessView){
        _accessView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_cell_rightArrow"]];
    }
    return _accessView;
}
+(instancetype)cellwithTableView:(UITableView*)tableView{
    static NSString* MainID=@"maincell";
    DropDownMainCell* cell=[tableView dequeueReusableCellWithIdentifier:MainID ];
    if(!cell){
        cell=[[DropDownMainCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MainID];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if([super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setBackgroundView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dropdown_leftpart"]]];
        [self setSelectedBackgroundView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dropdown_left_selected"]]];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if([super initWithFrame:frame]){
        
    }
    return self;
}
-(void)setItem:(id<DropDownMenuItemDelegate>)item{
    self.textLabel.text=[item title];
    if([item respondsToSelector:@selector(small_image)]){
        NSString* imageName=[item small_image];
        self.imageView.image=[UIImage imageNamed:imageName];
    }
    if([item subTitle].count>0){
        self.accessoryView=self.accessView;
    }
}
@end
