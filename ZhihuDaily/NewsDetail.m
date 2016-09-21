//
//  NewsDetail.m
//  ZhihuDaily
//
//  Created by 孤岛 on 16/9/21.
//  Copyright © 2016年 孤岛. All rights reserved.
//

#import "NewsDetail.h"
#import "AFNetworking.h"
@interface NewsDetail ()
@property (weak, nonatomic) IBOutlet UITextView *DetailText;

@end

@implementation NewsDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*获得HTML代码，然后在textview中显示*/
    self.title = self.newstitle;
    NSString *URLText = [NSString stringWithFormat:@"api/4/news/%@",self.newsid];
    NSString *encodeURl= [URLText stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [[NetworkHelper ShareHttpManager]GET:encodeURl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (!(responseObject == nil)) {
            NSDictionary *dict = responseObject;
            NSString  *message = dict[@"body"];
           
//            NSString *encodemessage = [message cStringUsingEncoding:NSUnicodeStringEncoding];
            NSData *data             = [message dataUsingEncoding:NSUnicodeStringEncoding];
            NSDictionary *options    = @{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType};
            NSAttributedString *html = [[NSAttributedString alloc]initWithData:data
                                                                       options:options
                                                            documentAttributes:nil
                                                                         error:nil];
            self.DetailText.attributedText = html;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure");
    }];
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
