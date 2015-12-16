//
//  DropDownMenu.h
//  团购
//
//  Created by tanhui on 15/5/24.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DropDownMenuItemDelegate <NSObject>

@required
@property(strong,nonatomic,readonly)NSString* title;
@property(strong,nonatomic,readonly)NSArray* subTitle;

@optional
@property(strong,nonatomic)NSString* small_image;
@property(strong,nonatomic)NSString* small_image_highlight;

@end

@protocol DropDownNoteDelegate <NSObject>
@optional
-(void)clickWithMainIndex:(int)mainIndex andSubIndex:(int)subIndex;
-(void)clickWithMainIndex:(int)mainIndex ;



@end
@interface DropDownMenu : UIView
+(instancetype)Dropmenu;
@property(assign,nonatomic)id<DropDownNoteDelegate>delegate;
-(void)setMainRow:(int)mainRow;
-(void)setSubRow:(int)subRow;
@property(strong,nonatomic)NSArray* items;
@end
