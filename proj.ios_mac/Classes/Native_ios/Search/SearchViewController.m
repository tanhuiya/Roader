//
//  SearchViewController.m
//  团购
//
//  Created by tanhui on 15/6/6.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import "SearchViewController.h"
#import "UIView+Extension.h"
#import "UIView+AutoLayout.h"
#import "FindDealsParam.h"
#import "DpDealTool.h"
#import "FindDealsReslut.h"
#import "UIBarButtonItem+Extension.h"
#import "MJRefresh.h"
#import "MBProgressHUD+NJ.h"
@interface SearchViewController ()<UISearchBarDelegate>
@property(nonatomic,weak)UISearchBar* searchBar;
@property(nonatomic,strong)FindDealsParam* lastParam;
@property(assign,nonatomic)int total;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"icon_back" highImage:@"icon_back_highlighted"];
    [self setupSearchBar];
    [self setupRefresh];
}
-(void)setupRefresh{
    [self.collectionView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
}
-(NSString *)imageName{
    return @"icon_deals_empty";
}
-(void)setupSearchBar{
    UIView *titleView=[[UIView alloc]init];
    titleView.width=400;
    titleView.height=40;
    self.navigationItem.titleView=titleView;
    
    UISearchBar* searchBar=[[UISearchBar alloc]init];
    [searchBar setBackgroundImage:[UIImage imageNamed:@"bg_login_textfield"]];
    [titleView addSubview:searchBar];
    self.searchBar=searchBar;
    searchBar.delegate=self;
    [searchBar autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    
}

-(void)back{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)loadMore{
    
    FindDealsParam* params=[[FindDealsParam alloc]init];
    params.city=self.selectedCity.name;
    params.keyword=self.searchBar.text;
    params.page=@([self.lastParam.page integerValue]+1);
    if(!params){
        return;
    }
    params.page=@([self.lastParam.page intValue]+1);
    [DpDealTool FindDealsWithParams:params success:^(FindDealsReslut *result) {
        //如果不是同一个请求，返回
        [self.collectionView.footer endRefreshing];
        
        if(params!=self.lastParam)
            return ;
        [self.deals addObjectsFromArray:result.deals];
        [self.collectionView reloadData];
        
    } error:^(NSError *error) {
        [self.collectionView.footer endRefreshing];
        if(params!=self.lastParam)
            return ;
        params.page=@([self.lastParam.page intValue]-1);
        
        NSLog(@"网络错误!!!");
    }];
    self.lastParam=params;
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar endEditing:YES];
    [MBProgressHUD showMessage:@"正在加载..." toView:self.navigationController.view];
    FindDealsParam* params=[[FindDealsParam alloc]init];
    params.city=self.selectedCity.name;
    params.keyword=searchBar.text;
    params.page=@(1);
    [DpDealTool FindDealsWithParams:params success:^(FindDealsReslut *result) {
        //如果不是同一个请求，返回
        [MBProgressHUD hideHUDForView:self.navigationController.view];
        if(params!=self.lastParam)
            return ;
        self.total=result.total_count;
        [self.deals removeAllObjects];
        [self.deals addObjectsFromArray:result.deals];
        [self.collectionView reloadData];
    } error:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.navigationController.view];
        if(params!=self.lastParam)
            return ;
        [MBProgressHUD showError:@"网络故障，请稍后再试..." toView:self.navigationController.view];
    }];
    self.lastParam=params;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    self.collectionView.footer.hidden=self.deals.count==self.total;
    return [super collectionView:collectionView numberOfItemsInSection:section];
}
@end
