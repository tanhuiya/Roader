//
//  DealBuyController.m
//  DianPing
//
//  Created by tanhui on 15/12/13.
//  Copyright © 2015年 tanhui. All rights reserved.
//

#import "DealBuyController.h"
#import "Masonry.h"
@interface DealBuyController ()
@property(strong,nonatomic)UIWebView* webView;

@end

@implementation DealBuyController
-(UIWebView *)webView{
    if (!_webView) {
        _webView=[[UIWebView alloc]init];
    }
    return _webView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
