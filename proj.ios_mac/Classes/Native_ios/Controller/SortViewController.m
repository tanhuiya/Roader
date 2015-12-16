//
//  CategoryViewController.m
//  团购
//
//  Created by tanhui on 15/5/24.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//

#import "SortViewController.h"
#import "MetaDataTool.h"
#import "Sort.h"
#import "notes.h"
#import "UIView+Extension.h"
@interface SortButton:UIButton
@property(nonatomic,strong)Sort* sort;
@end
@implementation SortButton
-(void)setSort:(Sort *)sort{
    _sort=sort;
   
    [self setTitle:sort.label forState:UIControlStateNormal];
}
-(void)setHighlighted:(BOOL)highlighted{
    
}
-(instancetype)initWithFrame:(CGRect)frame{
    if([super initWithFrame:frame]){
        [self setBackgroundImage:[UIImage imageNamed:@"btn_filter_normal"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"btn_filter_selected"] forState:UIControlStateSelected];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        self.titleLabel.font=[UIFont systemFontOfSize:15];
    }
    return self;
}

@end

@interface SortViewController ()
@property(strong,nonatomic)SortButton* selectedButton;
@end

@implementation SortViewController



-(void)btnClicked:(SortButton*)btn{
    self.selectedButton.selected=NO;
    btn.selected=YES;
    
    self.selectedButton=btn;
//    NSString* title=btn.titleLabel.text;
    int index=-1;
    for(int i=0;i<self.view.subviews.count;i++){
        UIView* view=self.view.subviews[i];
        if([view isKindOfClass:[SortButton class]]){
            index++;
            if(view==btn)
                break;
        }
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:SortSelectedNotification object:nil userInfo:@{SortParam:[[MetaDataTool shardWithDataTool] sorts][index]}];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSArray* sorts=[[MetaDataTool shardWithDataTool] sorts];
    CGFloat btnX=15;
    CGFloat MarginY=15;
    CGFloat btnWidth=self.view.width-btnX*2;
    CGFloat ContentY=0;
    for(int i=0;i<sorts.count;i++){
        SortButton* btn=[[SortButton alloc]init];
        btn.sort=sorts[i];
        btn.x=btnX;
        btn.height=30;
        btn.width=btnWidth;
        btn.y=i*(btn.height+MarginY)+MarginY;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:btn];
        ContentY=btn.y+btn.height;
    }
    UIScrollView* sc=(UIScrollView*)self.view;
    sc.contentSize=CGSizeMake(0, ContentY);

    self.view.backgroundColor=[UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
