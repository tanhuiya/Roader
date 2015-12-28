//
//  DetailDealController.m
//  团购
//
//  Created by tanhui on 15/6/3.
//  Copyright (c) 2015年 tanhui. All rights reserved.
//
//556fdd2c67e58e959d0046d4
#import "DetailDealController.h"
#import "PriceLabel.h"
#import "UIView+AutoLayout.h"
#import "SingleDealParam.h"
#import "SingleDealResult.h"
#import "DpDealTool.h"
#import "UIImageView+WebCache.h"
//#import "AppDelegate.h"
#import "UMSocial.h"
#import "MBProgressHUD+NJ.h"
#import "DealLoaclTool.h"
#import "DealBuyController.h"
#define  UMKEY @"556fdd2c67e58e959d0046d4"
@interface DetailDealController ()<UIWebViewDelegate,UMSocialUIDelegate>
@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (weak, nonatomic) IBOutlet UILabel *decs;
@property (weak, nonatomic) IBOutlet UILabel *currentPrice;
@property (weak, nonatomic) IBOutlet PriceLabel *OriginalPrice;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *coucang;
@property (retain, nonatomic) IBOutlet UIView *BottomView;

@property (weak, nonatomic) IBOutlet UIButton *timeOut;
@property (weak, nonatomic) IBOutlet UIButton *leftTime;
@property (weak, nonatomic) IBOutlet UIButton *timeOutChange;
@property (weak, nonatomic) IBOutlet UIButton *saleNumber;
@property (weak, nonatomic) UIActivityIndicatorView* loadingView;
@end

@implementation DetailDealController


#pragma mark CircleLife

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.webView.delegate=self;
    
//    [self setupRight];
    [self setupNav];
    [self setupLeft];
    //保存
    [[DealLoaclTool shardWithLocalTool]addHistoryDeal:self.deal];
    
    if([[[DealLoaclTool shardWithLocalTool]getCollectionDeals] containsObject:self.deal]){
        self.coucang.selected=YES;
    }
    CGSize size = [self.BottomView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    NSLog(@"%@",NSStringFromCGSize(size));
}
#pragma mark Actions

- (IBAction)buyClicked:(id)sender {
    DealBuyController * vc = [[DealBuyController alloc]init];
    vc.urlStr=self.deal.deal_h5_url;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)shouCang:(UIButton*)button {
    if(!button.selected){
        [[DealLoaclTool shardWithLocalTool]addCollectionDeal:self.deal];
        [MBProgressHUD showSuccess:@"收藏成功" toView: self.view];
    }else{
        [[DealLoaclTool shardWithLocalTool]removeCollectionDeal:self.deal];
        [MBProgressHUD showSuccess:@"取消收藏" toView:self.view];
        
    }
    button.selected=!button.isSelected;
    
}
- (IBAction)share:(UIButton *)sender {
    NSString* str=[NSString stringWithFormat:@"[%@]  %@  %@ ",self.Title.text,self.decs.text,self.deal.deal_h5_url];
//    [UMSocialSnsService presentSnsController:self appKey:UMKEY shareText:str shareImage:self.imageView.image shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,nil] delegate:nil];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:UMKEY
                                      shareText:str
                                     shareImage:self.imageView.image
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,nil]
                                       delegate:self];
}
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}
-(void)dismissVC{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark PrivateMethod
-(void)setupNav{
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_navigation_close"] style:UIBarButtonItemStyleDone target:self action:@selector(dismissVC)];
    self.navigationItem.title=@"商品详情";
}
- (void)updataLeftData{
    self.Title.text=self.deal.title;
    self.decs.text=self.deal.desc;
    self.currentPrice.text=[NSString stringWithFormat:@"￥%@",self.deal.current_price];
    self.OriginalPrice.text=[NSString stringWithFormat:@"￥%@",self.deal.list_price];
    self.timeOut.selected=self.deal.restrictions.is_refundable;
    self.timeOutChange.selected=self.deal.restrictions.is_reservation_required;
    [self.saleNumber setTitle:[NSString stringWithFormat:@"已售%d",self.deal.purchase_count] forState:UIControlStateNormal];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.deal.image_url]  placeholderImage:[UIImage imageNamed:@"placeholder_deal"]];
    NSDateFormatter* fomatter=[[NSDateFormatter alloc]init];
    fomatter.dateFormat=@"yyyy-MM-dd";
    NSDate * endData=[[fomatter dateFromString:self.deal.purchase_deadline]dateByAddingTimeInterval:24*3600];
    NSDate*  today=[NSDate date];
    NSCalendar* calendar=[NSCalendar currentCalendar];
    NSCalendarUnit unit=NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitDay;
    NSDateComponents* compoment=[calendar components:unit fromDate:today toDate:endData options:0 ];
    if(compoment.day>365){
        [self.leftTime setTitle:@"永不过期" forState:UIControlStateNormal];
    }else{
        NSString* str=[NSString stringWithFormat:@"还剩%ld天%ld时%ld分",compoment.day ,compoment.hour,compoment.minute];
        [self.leftTime setTitle:str forState:UIControlStateNormal];
    }
}
- (void)setupLeft{
    [self updataLeftData];
    NSString* ID=self.deal.deal_id;
    SingleDealParam* param = [[SingleDealParam alloc]init];
    param.deal_id=ID;
    [DpDealTool GetSingleDealWithParams:param success:^(SingleDealResult *result) {
        self.deal=[result.deals lastObject];
        [self updataLeftData];
    } error:^(NSError *error) {
        NSLog(@"加载失败");
    }];
}
//- (void)setupRight{
//    NSURL* url=[NSURL URLWithString:self.deal.deal_h5_url];
//    NSURLRequest* request=[NSURLRequest requestWithURL:url];
//    
//    UIActivityIndicatorView* loadingView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    [self.webView addSubview:loadingView];
//    
//    [loadingView autoCenterInSuperview];
//    [loadingView startAnimating];
//    [self.webView loadRequest:request];
//    self.loadingView=loadingView;
//}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.loadingView removeFromSuperview];
//    NSString* ID=self.deal.deal_id;
//    ID=[ID substringFromIndex:[ID rangeOfString:@"-"].location+1];
//    NSString* urlstr=[NSString stringWithFormat:@"http://lite.m.dianping.com/group/deal/moreinfo/%@",ID];
//    if([webView.request.URL.absoluteString isEqualToString:urlstr]){
//        NSMutableString* js=[NSMutableString string];
//        [js appendString:@"var bodyHTML='';"];
//        [js appendString:@"var link=document.body.getElementsByTagName('link')[0];"];
//        [js appendString:@"bodyHTML+=link.outerHTML;"];
//        [js appendString:@"var divs=document.getElementsByClassName('detail-info');"];
//        [js appendString:@"for(var i=0;i<=divs.length;i++){"];
//        [js appendString:@"var div=divs[i];"];
//        [js appendString:@"if(div){bodyHTML+=div.outerHTML;}"];
////        [js appendString:@"bodyHTML+=divs[i].outerHTML;"];
//        [js appendString:@"}"];
//        [js appendString:@"document.body.innerHTML=bodyHTML;"];
////        NSLog(@"%@",js);
//        [webView stringByEvaluatingJavaScriptFromString:js];
//    }else{
//        NSString* js=[NSString stringWithFormat:@"window.location.href='%@';",urlstr];
//        [webView stringByEvaluatingJavaScriptFromString:js];
//    }
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    NSLog(@"%@",request.URL.absoluteString);
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//var bodyHTML='';
//var link=document.body.getElementsByTagName('link')[0];
//bodyHTML+=link.outerHTML;
//var divs=document.getElementsByClassName('detail-info');
//for(var i=0;i<divs.length;i++){
//    var div=divs[i];
//    if(div){bodyHTML+=div.outerHTML;}
//}
//document.body.innerHTML=bodyHTML;


@end
