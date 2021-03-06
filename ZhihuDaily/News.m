//
//  News.m
//  ZhihuDaily
//
//  Created by 孤岛 on 16/9/13.
//  Copyright © 2016年 孤岛. All rights reserved.
//

#import "News.h"

@interface News ()
@property (weak, nonatomic) IBOutlet UIScrollView *topimages;
@property (weak, nonatomic) IBOutlet UIImageView *topimage;
//@property (weak, nonatomic) IBOutlet UIImageView *topimage;
@property(strong,nonatomic) NSMutableArray *newsDetail;
@property (weak, nonatomic) IBOutlet UIPageControl *pagecontrol;

@end

@implementation News

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.newsDetail = [NSMutableArray array];
    NSString *URLtext = [NSString stringWithFormat:@"api/4/news/latest"];
    [[NetworkHelper ShareHttpManager]GET:URLtext parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject != nil) {
            NSDictionary *dict  = responseObject;
            NSMutableArray *result = dict[@"stories"];
//            NSMutableArray *result = responseObject;
            [self.newsDetail removeAllObjects];
            [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *results  = obj;
                NSString     *imageurl = results[@"images"];
                NSString     *newsid   = results[@"id"];
                NSString     *title    = results[@"title"];
                NewsItem *Item  = [[NewsItem alloc]init];
                Item.newsimage  = imageurl;
                Item.newsid     = newsid;
                Item.newstitle  = title;
//                [self.newsDetail setValue:imageurl forKey:@"images"];
//                [self.newsDetail setValue:newsid   forKey:@"id"];
//                [self.newsDetail setValue:title    forKey:@"title"];
                [self.newsDetail addObject:Item];
                //异步调用
                NSOperationQueue *opreationQueue = [[NSOperationQueue alloc]init];
                NSInvocationOperation *op = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(downloadTopImage) object:nil];
                [opreationQueue addOperation:op];
//                [self downloadTopImage];
            }];
                [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure");
    }];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changepages:(id)sender {
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return self.newsDetail.count;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return self.newsDetail.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    News_cell *cell = [tableView dequeueReusableCellWithIdentifier:@"news" forIndexPath:indexPath];
    NewsItem *Item = self.newsDetail[indexPath.row];
    NSString *imageString = [NSString stringWithFormat:@"%@",Item.newsimage];
    UIImage *image = [self downloadImage:imageString];
    cell.image.image = image;
    cell.abstract.numberOfLines = 0;
    cell.abstract.text = Item.newstitle;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - prepareforsegue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        NewsDetail *detail = segue.destinationViewController;
        NSInteger selectindex = [[self.tableView indexPathForSelectedRow]row];
        NewsItem *Item = [self.newsDetail objectAtIndex:selectindex];
        detail.newsid = Item.newsid;
        detail.newstitle = Item.newstitle;
        
    }
}
#pragma mark - download image
- (UIImage *)downloadImage:(NSString *)imageString{
    imageString = [imageString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    imageString = [imageString stringByReplacingOccurrencesOfString:@" " withString:@""];
    imageString = [imageString stringByReplacingOccurrencesOfString:@"(" withString:@""];
    imageString = [imageString stringByReplacingOccurrencesOfString:@")" withString:@""];
    imageString = [imageString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    NSURL *imageURL = [NSURL URLWithString:imageString];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *image1 = [UIImage imageWithData:imageData];
    
    return image1;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark- download
- (void)downloadTopImage{
    NewsItem *Item = [self.newsDetail objectAtIndex:0];
    NSString *topimageurl = [NSString stringWithFormat:@"%@",Item.newsimage];
    topimageurl = [topimageurl stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    topimageurl = [topimageurl stringByReplacingOccurrencesOfString:@" " withString:@""];
    topimageurl = [topimageurl stringByReplacingOccurrencesOfString:@"(" withString:@""];
    topimageurl = [topimageurl stringByReplacingOccurrencesOfString:@")" withString:@""];
    topimageurl = [topimageurl stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    NSURL *url = [NSURL URLWithString:topimageurl];
    NSData *data = [NSData dataWithContentsOfURL:url];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.topimage.image = [UIImage imageWithData:data];
    });

    
}
@end
