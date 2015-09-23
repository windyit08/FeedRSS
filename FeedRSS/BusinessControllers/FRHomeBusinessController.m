//
//  FRFavoriteBusinessController.m
//  FeedRSS
//
//  Created by TCE on 9/18/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import "FRHomeBusinessController.h"
#import "HomeCell.h"
#import "FRNewsModel.h"
#import "XMLParser.h"
#import "FRNewsObject.h"
#import "FRHomeBusinessController.h"
#import "FRHomeViewController.h"
#import "FRPostDAO.h"

#define homeNews @"http://vnexpress.net/rss/tin-moi-nhat.rss"

#pragma mark - FRHomeBusinessController

@implementation FRHomeBusinessController{
}

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

-(void)loadAllNews:(void (^)(void))success failure:(void (^)(NSString *errorMessage))failure {
    
    [self.dataSource loadAllNews:success failure:failure];
    
}

@end

#pragma mark - FRHomeDataSource

@implementation FRHomeDataSource

- (NSArray *)newsList {
    return self.news;
}

- (void)loadAllNews:(void(^)(void))success failure:(void (^)(NSString *errorMessage))failure {
    FRNewsModel *newsModel = [[FRNewsModel alloc] init];
    [newsModel requestNewsList:homeNews success:^(FRNewsObject *newsObject) {
        NSLog(@"[FR] Success to get rss");
        NSLog(@"FRNewsModelTest: sucess here");
        XMLParser *parser = [[XMLParser alloc] init];
        self.news = [[parser parserXMLFromData:(NSData *)newsObject] copy];
//        for(int i = 0; i < newsArray.count; i++){
//            FRNewsObject *frNew = [newsArray objectAtIndex:i];
//            if(frNew != nil){
//                NSLog(@"---------------News %i---------------", i);
//                NSLog(@"testFethTopNews: (title %d) %@", i, frNew.title);
//                NSLog(@"testFetchTopNews: (pubDate %d) %@", i, frNew.pubDate);
//                NSLog(@"testFetchTopNews: (pubDate %d) %@", i, frNew.description);
//            }
//        }
        success();
    } failure:^(NSString *errorMess) {
        NSLog(@"[FR] Fail to get rss");
        NSLog(@"FRNewsModelTest: fail >> %@", errorMess);
        failure(errorMess);
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
        cell.thumbnailImageView.image = [UIImage imageNamed:@"husky.jpg"];
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