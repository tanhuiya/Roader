//
//  CollectionHeadView.m
//  DianPing
//
//  Created by tanhui on 15/12/13.
//  Copyright © 2015年 tanhui. All rights reserved.
//

#import "CollectionHeadView.h"
#import "CateroryBtn.h"
#import "Masonry.h"
#import "MetaDataTool.h"

@interface CollectionHeadView ()<UIScrollViewDelegate>
@property(strong,nonatomic)UIScrollView * scrollView;
@property(strong,nonatomic)UIPageControl* pageControl;
@end

@implementation CollectionHeadView

#pragma mark lifeCIrcle
-(instancetype)initWithFrame:(CGRect)frame{
    if([super initWithFrame:frame]){
        [self addSubview:self.scrollView];
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        self.categories=[MetaDataTool shardWithDataTool].categories;
//        self.scrollView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200);
        [self addButtons];
        [self insertSubview:self.pageControl aboveSubview:self.scrollView];
        [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.scrollView.mas_bottom);
        }];
    }
    return self;
}

#pragma mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int curPage = scrollView.contentOffset.x/self.frame.size.width+0.5;
    self.pageControl.currentPage=curPage;
}

#pragma mark privare Method
-(void)addButtons{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    NSInteger page = (self.categories.count+7)/8;
    self.scrollView.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width*page, 0);
    
    int row =2,col =4;
    CGFloat height = 80;
    CGFloat topMargin=10;
    CGFloat xMargin = (self.frame.size.width-col*BtnWidth)/(col+1);
    NSInteger index =0;
    for(int i=0; i<page;i++){
        if(i!=page-1){
            for(int j=0;j<8;j++){
                CateroryBtn* btn =[[CateroryBtn alloc]init];
                if(j<col){
                    btn.frame=CGRectMake(j*(BtnWidth+xMargin)+xMargin,topMargin, BtnWidth, height);
                }else{
                    btn.frame=CGRectMake((j-4)*(BtnWidth+xMargin)+xMargin, height+topMargin, BtnWidth, height);
                }
                btn.category=self.categories[index++];
                [self.scrollView addSubview:btn];
                
            }
        }else{
            for (int j=0; j<self.categories.count-(page-1)*8; j++) {
                CateroryBtn* btn =[[CateroryBtn alloc]init];
                if(j<col){
                    btn.frame=CGRectMake((page-1)*screenWidth+j*(BtnWidth+xMargin)+xMargin,topMargin, BtnWidth, height);
                }else{
                    btn.frame=CGRectMake((page-1)*screenWidth+(j-4)*(BtnWidth+xMargin)+xMargin, height+topMargin, BtnWidth, height);
                }
                btn.category=self.categories[index++];
                [self.scrollView addSubview:btn];
            }
        }
    }
}

#pragma mark getter and setter
-(UIPageControl *)pageControl{
    if(!_pageControl){
        _pageControl=[[UIPageControl alloc]init];
        _pageControl.numberOfPages=(self.categories.count+7)/8;
        _pageControl.pageIndicatorTintColor=[UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor=[UIColor orangeColor];
    }
    return _pageControl;
}
-(UIScrollView *)scrollView{
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.pagingEnabled=YES;
        _scrollView.backgroundColor=[UIColor whiteColor];
        _scrollView.delegate=self;
    }
    return _scrollView;
}
@end
