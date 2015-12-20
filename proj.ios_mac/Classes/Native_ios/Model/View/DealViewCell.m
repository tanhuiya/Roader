//
//  DealViewCell.m
//  团购
//
//  Created by tanhui on 15/5/26.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import "DealViewCell.h"
#import "UIView+Extension.h"
#import "UIImageView+WebCache.h"
@interface DealViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *ImageNew;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *listPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *purchaseCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *coverButton;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImage;

@end
@implementation DealViewCell
- (IBAction)coverClick:(UIButton *)sender {
    self.deal.isCheck=!self.deal.isCheck;
    self.selectedImage.hidden=!self.selectedImage.isHidden;
    if([self.delegate respondsToSelector:@selector(coverDidClicked:)]){
        [self.delegate coverDidClicked:sender];
    }
}
-(void)drawRect:(CGRect)rect{
    [[UIImage imageNamed:@"bg_dealcell"]drawInRect:rect];
}

- (void)setDeal:(Deal *)deal
{
    _deal = deal;
    
    // 图片
 [self.imageView sd_setImageWithURL:[NSURL URLWithString:deal.image_url] placeholderImage:[UIImage imageNamed:@"placeholder_deal"]];

    // 标题
    self.titleLabel.text = deal.title;
    
    // 描述
    self.descLabel.text = deal.desc;
    // 现价
    self.currentPriceLabel.text = [NSString stringWithFormat:@"￥%@", deal.current_price];
//    self.nowPriceLabel.constant=[self.currentPriceLabel.text sizeWithAttributes:@{NSFontAttributeName:self.currentPriceLabel.font}].width;
    
    // 原价
    self.listPriceLabel.text = [NSString stringWithFormat:@"￥%@", deal.list_price];
//    self.originalPriceLabel.constant=[self.listPriceLabel.text sizeWithAttributes:@{NSFontAttributeName:self.listPriceLabel.font}].width+1;
    // 购买数
    self.purchaseCountLabel.text = [NSString stringWithFormat:@"已售出%d", deal.purchase_count];
    
    NSDateFormatter* formatter=[[NSDateFormatter alloc]init];
    formatter.dateFormat=@"yyyy-MM-dd";
    NSString* today=[formatter stringFromDate:[NSDate date]];
  
    self.ImageNew.hidden=([today compare:deal.publish_date]==NSOrderedDescending);
    
    self.coverButton.hidden=!self.deal.isEditing;
    if(self.deal.isCheck){
        self.selectedImage.hidden=NO;
    }else{
        self.selectedImage.hidden=YES;
    }
}


@end
