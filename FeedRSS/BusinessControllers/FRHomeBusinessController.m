//
//  FRFavoriteBusinessController.m
//  FeedRSS
//
//  Created by TCE on 9/18/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import "FRHomeBusinessController.h"
#import "HomeCell.h"
#import "FRNewsServices.h"
#import "XMLParser.h"
#import "FRNewsObject.h"
#import "FRHomeBusinessController.h"
#import "FRHomeViewController.h"
#import "FRArticleTableViewCell.h"

#pragma mark - FRHomeBusinessController


@implementation FRHomeBusinessController{}

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = [[FRHomeDataSource alloc] init];
    }
    self.newsArray = _newsArray;
    NSLog(@"[FR] Start test example");
    return self;
}

-(void)loadAllNews:(SuccessBlock)success failure:(FailureBlock)failure {
    
    [self.dataSource loadAllNews:success failure:failure];
    
}

@end

#pragma mark - FRHomeDataSource

@implementation FRHomeDataSource{
    NSString *homeNews;
}

- (NSArray *)newsList {
    return self.news;
}

- (void)loadAllNews:(SuccessBlock)success failure:(FailureBlock)failure {
//    homeNews = [NSString stringWithFormat:@"%@%@", BASE_URL,HOME_NEWS_CONTENT];
    homeNews= @"http://vnexpress.net/rss/tin-moi-nhat.rss";
    FRNewsServices *newsServices = [[FRNewsServices alloc] init];
    [newsServices requestNewsList:homeNews success:^(id data) {
        NSLog(@"[FR] Success to get rss");
        NSLog(@"FRNewsModelTest: sucess here");
        XMLParser *parser = [[XMLParser alloc] init];
        self.news = [[parser parserXMLFromData:(NSData *)data] copy];
        success(self.news);
    } failure:^(NSInteger errorCode, NSString *errorMsg)  {
        NSLog(@"[FR] Fail to get rss");
        NSLog(@"FRNewsModelTest: fail >> %@", errorMsg);
        failure(errorCode, errorMsg);
    }];
}

#pragma mark - UITableViewDataSource methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    {
        FRNewsObject *newsObj = [self.news objectAtIndex:indexPath.row];
        if(newsObj == nil){
            return nil;
        }
        HomeCell * cell = nil;
        static NSString *simpleTableIndentifier = @"HomeCell";
        cell = (HomeCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIndentifier];
        if(cell == nil){
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HomeCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.nameLabel.text = newsObj.title;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:newsObj.urlImage]]];
            dispatch_async(dispatch_get_main_queue(), ^{
                FRArticleTableViewCell * cell = (FRArticleTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
                cell.thumbnailImageView.image = img;
            });
        });
        [cell.btn addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
}

- (void)buttonTapped:(id)sender {
    NSLog(@"buttonTapped");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.news count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
           }
}

@end