//
//  MTDealsViewController.m
//  团购
//
//  Created by tanhui on 15/5/23.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//
#import "DealLoaclTool.h"
#import "Region.h"
#import "MTNavigationController.h"
#import "MetaDataTool.h"
#import "MTCategory.h"
#import "notes.h"
#import "MTDealsViewController.h"
#import "AwesomeMenu.h"
#import "UIView+AutoLayout.h"
#import "UIBarButtonItem+Extension.h"
#import "DealsTopMenu.h"
#import "SortViewController.h"
#import "CategoryController.h"
#import "RegionViewController.h"
#import "City.h"
#import "FindDealsParam.h"
#import "FindDealsReslut.h"
#import "Sort.h"
#import "DpDealTool.h"
#import "MJRefresh.h"
#import "UIView+Extension.h"
#import "DealHistoryController.h"
#import "DealColletionController.h"
#import "SearchViewController.h"
//#import "MapViewController.h"
#import "MBProgressHUD+NJ.h"
#import "CollectionHeadView.h"

@interface MTDealsViewController()<AwesomeMenuDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property(strong,nonatomic)AwesomeMenu* menu;
@property(strong,nonatomic)DealsTopMenu *CategoryMenu;
@property(strong,nonatomic)DealsTopMenu *CityMenu;
@property(strong,nonatomic)DealsTopMenu *SortMenu;


@property(nonatomic,strong)City* selectedCity;
@property(nonatomic,strong)Region* selectedRegion;
@property(nonatomic,strong)NSString* selectedSubRegion;

@property(nonatomic,strong)MTCategory* selectedCategory;
@property(nonatomic,strong)NSString* selectedSubCategory;

@property(nonatomic,strong)Sort* selectedSort;

@property(nonatomic,strong)FindDealsParam* lastParam;

@property(nonatomic,assign)int total;
@end

@implementation MTDealsViewController



-(void)viewDidLoad{
    [super viewDidLoad];
    //从沙盒加载
    self.selectedCity=[[MetaDataTool shardWithDataTool]getLastCity];
    self.selectedSort=[[MetaDataTool shardWithDataTool]getLastSort];
    [self setCollectionView];
    [self setNotes];
    [self setupPath];
    [self setNavBar];
    
}


-(AwesomeMenuItem*)itemWithContentImage:(NSString*)content andHighlight:(NSString*)contentHighlight{
    UIImage *bgMenuItemImage = [UIImage imageNamed:@"bg_pathMenu_black_normal"];
//    UIImage *bgMenuItemImageHighlight=[UIImage imageNamed:@"icon_pathMenu_background_highlighted"];
    return  [[AwesomeMenuItem alloc]initWithImage:bgMenuItemImage highlightedImage:nil ContentImage:[UIImage imageNamed:content] highlightedContentImage:[UIImage imageNamed:contentHighlight]];
}
-(void)setNotes{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sortClicked:) name:SortSelectedNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cityClicked:) name:CitySelectedNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(regionClicked:) name:RegionSelectedNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(categoryClicked:) name:CategorySelectedNotification object:nil];
}

//
-(void)cityClicked:(NSNotification*)note{
//    RegionViewController* rvc=(RegionViewController*) self.regionPop.contentViewController;
//    rvc.city=note.userInfo[CityParam];
    
    self.CityMenu.Title.text=[note.userInfo[CityParam] name];
    self.selectedCity=note.userInfo[CityParam];
    self.selectedRegion=[self.selectedCity.regions firstObject];
    self.CityMenu.Title.text=[NSString stringWithFormat:@"%@-全部",self.selectedCity.name];
    self.CityMenu.SubTitle.text=nil;
    [self loadNewDeals];
    [self.collectionView.header beginRefreshing];
    //存储最近使用城市
    [[MetaDataTool shardWithDataTool]addCityRecent:self.selectedCity];

}
-(void)sortClicked:(NSNotification*)note{
    Sort* sort= note.userInfo[SortParam];
    self.SortMenu.SubTitle.text=sort.label;
    self.selectedSort=sort;
//    [self loadNewDeals];
    [self.collectionView.header beginRefreshing];
    [[MetaDataTool shardWithDataTool]saveSort:sort];
}
-(void)regionClicked:(NSNotification*)note{
    Region* region= note.userInfo[RegionParam];
    NSString* subregion= note.userInfo[SubRegionParam];
    NSString* title=[NSString stringWithFormat:@"%@-%@",self.selectedCity.name ,region.name];
    self.CityMenu.Title.text=title;
    self.CityMenu.SubTitle.text=subregion;
    self.selectedRegion=region;
    self.selectedSubRegion=subregion;
//    [self loadNewDeals];
    [self.collectionView.header beginRefreshing];
}
-(void)categoryClicked:(NSNotification*)note{
    MTCategory* category= note.userInfo[CategoryParam];
    NSString* subcate= note.userInfo[CategorySubParam];
    self.CategoryMenu.Title.text=category.title;
    self.CategoryMenu.SubTitle.text=subcate;
    self.selectedCategory=category;
    self.selectedSubCategory=subcate;
//    [self loadNewDeals];
    [self.collectionView.header beginRefreshing];
    
//    [[MetaDataTool shardWithDataTool]saveCategory:category];
}
-(FindDealsParam*)getFindDeal{
    FindDealsParam* params=[[FindDealsParam alloc]init];
    
    if(self.selectedCity){
        params.city=self.selectedCity.name;
    }else{
        return nil;
    }
    if(self.selectedCategory){
        if(![self.selectedCategory.name isEqualToString:@"全部分类"]){
            if(self.selectedCategory.subcategories.count==0){
                params.category=self.selectedCategory.name;
            }else{
                if([self.selectedSubCategory isEqualToString:@"全部"]){
                    params.category=self.selectedCategory.name;
                }else{
                    params.category=self.selectedSubCategory;
                    
                }
            }
        }
    }
    if(self.selectedRegion){
        if(![self.selectedRegion.name isEqualToString:@"全部"]){
            if(self.selectedRegion.subregions.count==0){
                params.region=self.selectedRegion.name;
            }else{
                if(![self.selectedSubRegion isEqualToString:@"全部"]){
                    params.region=self.selectedSubRegion;
                }
            }
        }
    }
    if(self.selectedSort){
        params.sort=self.selectedSort.value;
    }
    return params;
}
-(void)loadNewDeals{
    [MBProgressHUD showMessage:@"正在加载..." toView:self.navigationController.view];
    FindDealsParam* params=[self getFindDeal];
    if(!params){
        return;
    }
    [DpDealTool FindDealsWithParams:params success:^(FindDealsReslut *result) {
        //如果不是同一个请求，返回
        [self.collectionView.header endRefreshing];
        [MBProgressHUD hideHUDForView:self.navigationController.view];
        if(params!=self.lastParam)
            return ;
        self.total=result.total_count;
        [self.deals removeAllObjects];
        [self.deals addObjectsFromArray:result.deals];
        [self.collectionView reloadData];
    } error:^(NSError *error) {
        [self.collectionView.header endRefreshing];
        if(params!=self.lastParam)
            return ;
        [MBProgressHUD showError:@"网络故障，请稍后再试..." toView:self.navigationController.view];
    }];
    params.page=@(1);
    self.lastParam=params;
}
-(void)loadMoreDeals{
    FindDealsParam* params=[self getFindDeal];
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
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    self.collectionView.footer.hidden=self.deals.count==self.total;
    return [super collectionView:collectionView numberOfItemsInSection:section];
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    CollectionHeadView* reuseView=nil;
    if(kind==UICollectionElementKindSectionHeader){
        reuseView=(CollectionHeadView*)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headReuser" forIndexPath:indexPath];
//        UIView * bottom = [UIView new];
//        bottom.size = CGSizeMake(self.view.width, 100);
//        bottom.backgroundColor = [UIColor yellowColor];
//        [reuseView addSubview:bottom];
    }
    return reuseView;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={320,210};
    return size;
}

-(void)setCollectionView{
    [self.view setBackgroundColor:[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0]];
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    [self.collectionView addHeaderWithTarget:self action:@selector(loadNewDeals)];
    [self.collectionView addFooterWithTarget:self action:@selector(loadMoreDeals)];
    
    [self.collectionView.header beginRefreshing];
    
}



-(void)setRightBarButton{
    UIBarButtonItem* Serach_item=[UIBarButtonItem itemWithTarget:self action:@selector(SearchClicked) image:@"icon_search" highImage:@"icon_search"];
    Serach_item.customView.width=50;
    Serach_item.customView.height=30;
    self.navigationItem.rightBarButtonItems=@[Serach_item];
}
-(void)setLeftBarButton{
//    UIBarButtonItem* Icon=[UIBarButtonItem itemWithTarget:nil action:nil image:@"icon_meituan_logo" highImage:@"icon_meituan_logo"];
//    Icon.enabled=NO;
    DealsTopMenu* CategoryMenu=[DealsTopMenu menu];
    [CategoryMenu.imageButton setImage:[UIImage imageNamed:@"icon_category_highlighted_0"] forState:UIControlStateHighlighted];
    [CategoryMenu.imageButton setImage:[UIImage imageNamed:@"icon_category_0"] forState:UIControlStateNormal];
    CategoryMenu.Title.text=@"分类";
    CategoryMenu.SubTitle.text=@"全部";
    [CategoryMenu addTarget:self selector:@selector(categoryMenuClicked)];
    UIBarButtonItem* item1=[[UIBarButtonItem alloc]initWithCustomView:CategoryMenu];
    self.CategoryMenu=CategoryMenu;
    DealsTopMenu* CityMenu=[DealsTopMenu menu];
    [CityMenu.imageButton setImage:[UIImage imageNamed:@"icon_district_highlighted"] forState:UIControlStateHighlighted];
    [CityMenu.imageButton setImage:[UIImage imageNamed:@"icon_district"] forState:UIControlStateNormal];
        CityMenu.Title.text=[NSString stringWithFormat:@"%@-全部",self.selectedCity.name];
    CityMenu.SubTitle.text=@"地区";
    [CityMenu addTarget:self selector:@selector(regionMenuClicked)];
    UIBarButtonItem* item2=[[UIBarButtonItem alloc]initWithCustomView:CityMenu];
    self.CityMenu=CityMenu;
    DealsTopMenu* SortMenu=[DealsTopMenu menu];
    [SortMenu.imageButton setImage:[UIImage imageNamed:@"icon_sort_highlighted"] forState:UIControlStateHighlighted];
    [SortMenu.imageButton setImage:[UIImage imageNamed:@"icon_sort"] forState:UIControlStateNormal];
    SortMenu.Title.text=@"排序";
    SortMenu.SubTitle.text=self.selectedSort.label;
    [SortMenu addTarget:self selector:@selector(sortMenuClicked)];
    UIBarButtonItem* item3=[[UIBarButtonItem alloc]initWithCustomView:SortMenu];
    self.SortMenu=SortMenu;
    self.navigationItem.leftBarButtonItems=@[item1,item2,item3];
}
#pragma mark - 左边导航栏
-(void)categoryMenuClicked{
    CategoryController* categoryVC=[[CategoryController alloc]init];;
    categoryVC.selectedCategory=self.selectedCategory;
    categoryVC.selectedSubCategory=self.selectedSubCategory;
    [self.navigationController pushViewController:categoryVC animated:YES];
//    [self.categoryPop presentPopoverFromRect:self.CategoryMenu.bounds inView:self.CategoryMenu permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}
-(void)regionMenuClicked{
    RegionViewController* regionVC=[[RegionViewController alloc]init];;
    regionVC.selectedRegion=self.selectedRegion;
    regionVC.selectedSubRegion=self.selectedSubRegion;
    regionVC.city=self.selectedCity;
    [self.navigationController pushViewController:regionVC animated:NO];
//    [self.regionPop presentPopoverFromRect:self.CityMenu.bounds inView:self.CityMenu permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

}
    
-(void)sortMenuClicked{
    SortViewController* sortVC=[[SortViewController alloc]init];
    sortVC.selectedSort=self.selectedSort;
    [self.navigationController pushViewController:sortVC animated:YES];
}
-(NSString *)imageName{
    return @"icon_deals_empty";
}
#pragma mark - 右边导航栏

-(void)SearchClicked{
    SearchViewController* svc = [[SearchViewController alloc]init];
    svc.selectedCity=self.selectedCity;
    MTNavigationController* nvc=[[MTNavigationController alloc]initWithRootViewController:svc];
    [self presentViewController:nvc animated:YES completion:nil];
}
-(void)setNavBar{
    [self setRightBarButton];
    [self setLeftBarButton];
}
-(void)setupPath{
    AwesomeMenuItem* item1=[self itemWithContentImage:@"icon_pathMenu_mine_highlighted" andHighlight:@"icon_pathMenu_mine_highlighted"];
    AwesomeMenuItem* item2=[self itemWithContentImage:@"icon_pathMenu_collect_highlighted" andHighlight:@"icon_pathMenu_collect_highlighted"];
    AwesomeMenuItem* item3=[self itemWithContentImage:@"icon_pathMenu_scan_highlighted"
                                         andHighlight:@"icon_pathMenu_scan_highlighted"];
    AwesomeMenuItem* item4=[self itemWithContentImage:@"icon_pathMenu_more_highlighted"
                                         andHighlight:@"icon_pathMenu_more_highlighted"];
    
    NSArray* items=@[item1,item2,item3,item4];
    AwesomeMenuItem* startItem=[self itemWithContentImage:@"icon_pathMenu_mainMine_highlighted" andHighlight:@"icon_pathMenu_mainMine_highlighted"];
    AwesomeMenu* menu=[[AwesomeMenu alloc]initWithFrame:CGRectZero startItem:startItem menuItems:items];
    menu.menuWholeAngle=M_PI_2;
    menu.rotateAddButton=NO;
    menu.delegate=self;
    self.menu=menu;
    [self.view addSubview:menu];
    [menu autoSetDimensionsToSize:CGSizeMake(200, 200)];
    [menu autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [menu autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    UIImage* image=[UIImage imageNamed:@"icon_pathMenu_background"];
    UIImageView* iv=[[UIImageView alloc]initWithImage:image];
    [menu insertSubview:iv atIndex:0];
    [iv autoSetDimensionsToSize:iv.image.size];
    [iv autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [iv autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    
    menu.startPoint=CGPointMake(iv.image.size.width*0.5,200-iv.image.size.height*0.5);
}
-(void)awesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx{
    [self awesomeMenuDidFinishAnimationClose:menu];
    if(idx==1){
        DealColletionController* collection=[[DealColletionController alloc]init];
        collection.deals=[[DealLoaclTool shardWithLocalTool]getCollectionDeals];
        MTNavigationController* nav=[[MTNavigationController alloc]initWithRootViewController:collection];
        [self presentViewController:nav animated:YES completion:nil];
    }else if(idx==2){
        DealHistoryController* history=[[DealHistoryController alloc]init];
        history.deals=[[DealLoaclTool shardWithLocalTool]getHistoryDeals];
        MTNavigationController* nav=[[MTNavigationController alloc]initWithRootViewController:history];
        [self presentViewController:nav animated:YES completion:nil];
    }
}
-(void)awesomeMenuDidFinishAnimationClose:(AwesomeMenu *)menu{
    self.menu.startButton.contentImageView.image=[UIImage imageNamed:@"icon_pathMenu_mainMine_highlighted"];
}

-(void)awesomeMenuDidFinishAnimationOpen:(AwesomeMenu *)menu{
    self.menu.startButton.contentImageView.image=[UIImage imageNamed:@"icon_pathMenu_cross_highlighted"];
}

@end
