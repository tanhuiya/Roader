//
//  DealListController.m
//  团购
//
//  Created by tanhui on 15/6/5.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import "DealListController.h"
#import "EmptyView.h"
#import "UIView+Extension.h"
#import "DetailDealController.h"
#import "DealViewCell.h"
#import "Masonry.h"
#import "MTNavigationController.h"
#import "CollectionHeadView.h"
@interface DealListController ()<CoverClickDelegate>
@property(nonatomic,strong)EmptyView* emptyview;

@end

@implementation DealListController
-(instancetype)init{
    UICollectionViewFlowLayout* flowout=[[UICollectionViewFlowLayout alloc]init];
//    CGFloat Screenwidth = [UIDevice currentDevice].orientation==UIDeviceOrientationPortrait ? [UIScreen mainScreen].bounds.size.width : [UIScreen mainScreen].bounds.size.height;
    CGFloat Screenwidth =[UIScreen mainScreen].bounds.size.width<[UIScreen mainScreen].bounds.size.height ? [UIScreen mainScreen].bounds.size.width : [UIScreen mainScreen].bounds.size.height;
    CGFloat width=(Screenwidth-3*5)*0.5;
    flowout.itemSize=CGSizeMake(width , width+55);
    flowout.minimumInteritemSpacing=5;
    flowout.minimumLineSpacing=5;
    flowout.sectionInset=UIEdgeInsetsMake(0, 5, 0, 5);
    return [super initWithCollectionViewLayout:flowout];
}

static NSString * const reuseIdentifier = @"Cell";
-(NSMutableArray *)deals{
    if(!_deals){
        _deals=[NSMutableArray array];
    }
    return _deals;
}
-(EmptyView *)emptyview{
    if (!_emptyview) {
        _emptyview=[[EmptyView alloc]init];
        _emptyview.image=[UIImage imageNamed:self.imageName];
        [self.view insertSubview:_emptyview belowSubview:self.collectionView];
    }
    return _emptyview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:@"DealVIewCell"  bundle:nil]  forCellWithReuseIdentifier:@"deal"];
    [self.collectionView registerClass:[CollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headReuser"];
    // Do any additional setup after loading the view.
    [self setCollectionView];

}
-(void)setCollectionView{
    [self.view setBackgroundColor:[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0]];
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    
}
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [self setupLayout:[UIScreen mainScreen].bounds.size.width InterfaceOrientation:toInterfaceOrientation];
}

-(void)setupLayout:(CGFloat)width InterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    UICollectionViewFlowLayout* flowLayout=(UICollectionViewFlowLayout*)self.collectionViewLayout;
    flowLayout.minimumLineSpacing=20;
//    int widths=UIInterfaceOrientationIsPortrait(toInterfaceOrientation)?[UIScreen mainScreen].bounds.size.height:[UIScreen mainScreen].bounds.size.width;
    int items=UIInterfaceOrientationIsPortrait(toInterfaceOrientation)?2:3;
    CGFloat horizonMargin=(width-items*flowLayout.itemSize.width) / (items+1);
//    NSLog(@"%f----%f",flowLayout.itemSize.width,width);
       //    flowLayout.minimumInteritemSpacing=horizonMargin;
    flowLayout.sectionInset=UIEdgeInsetsMake(20, horizonMargin, 20, horizonMargin);
    
}
//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    [self setupLayout:self.view.width InterfaceOrientation:self.interfaceOrientation];
//}
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self setupLayout:self.view.width InterfaceOrientation:self.interfaceOrientation];
//}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    self.emptyview.hidden=self.deals.count!=0;
    return self.deals.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DetailDealController* controller=[[DetailDealController alloc]init];
    controller.deal=self.deals[indexPath.item];
    MTNavigationController* mvc = [[MTNavigationController alloc]initWithRootViewController:controller];
    [self presentViewController:mvc animated:YES completion:nil];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DealViewCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"deal" forIndexPath:indexPath];
    cell.delegate=self;
    cell.deal=self.deals[indexPath.item];
    return cell;
}

@end
