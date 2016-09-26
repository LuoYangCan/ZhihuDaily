//
//  NewsDetailWeb.m
//  ZhihuDaily
//
//  Created by 孤岛 on 2016/9/24.
//  Copyright © 2016年 孤岛. All rights reserved.
//

#import "NewsDetailWeb.h"

@interface NewsDetailWeb ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *DetailWeb;

@end

@implementation NewsDetailWeb

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.newstitle;
    NSString *URLText = [NSString stringWithFormat:@"api/4/news/%@",self.newsid];
    NSString *encodeURl= [URLText stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [[NetworkHelper ShareHttpManager]GET:encodeURl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (!(responseObject == nil)) {
            NSDictionary *dict = responseObject;
            NSString  *message1 = dict[@"body"];
            NSArray *css1 = dict[@"css"];
            NSString *css = css1[0];
            NSString  *message = [NSString stringWithFormat:@"<html><head><link rel=\"stylesheet\" href=%@></head><body>%@</body></html>",css,message1];
            [self.DetailWeb loadHTMLString:message baseURL:nil];//从HTML URL中uploadweb
            //            NSString *encodemessage = [message cStringUsingEncoding:NSUnicodeStringEncoding];
//            NSData *data             = [message dataUsingEncoding:NSUnicodeStringEncoding];
//            NSDictionary *options    = @{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType};
//            NSAttributedString *html = [[NSAttributedString alloc]initWithData:data
//                                                                       options:options
//                                                            documentAttributes:nil
//                                                                         error:nil];
//            self.DetailText.attributedText = html;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure");
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

//#pragma mark - webviewdelegate
//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    [webView stringByEvaluatingJavaScriptFromString:
//     @"var script = document.createElement('script');"
//     "script.type = 'text/javascript';"
//     "script.text = \"function ResizeImages() { "
//     "var myimg,oldwidth,oldheight;"
//     "var maxwidth=320;"// 图片宽度
//     "for(i=0;i<maxwidth;i++){""myimg.width = maxwidth;"
//     "}"
//     "}"
//     "}\";"
//     "document.getElementsByTagName('head')[0].appendChild(script);"];
//    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
