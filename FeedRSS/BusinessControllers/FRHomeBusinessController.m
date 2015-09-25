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
#import "FRPostDAO.h"
#import "Utils.h"


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

@implementation FRHomeDataSource{
    NSMutableArray* listFav;
}


- (NSArray *)newsList {
    return self.news;
}

- (void)loadAllNews:(void(^)(void))success failure:(void (^)(NSString *errorMessage))failure {
    FRNewsServices *newsModel = [[FRNewsServices alloc] init];
    listFav = [[FRPostDAO sharedInstance] listAllGuiOfFavorite];
    [newsModel requestNewsList:homeNews success:^(FRNewsObject *newsObject) {
        NSLog(@"[FR] Success to get rss");
        NSLog(@"FRNewsModelTest: sucess here");
        XMLParser *parser = [[XMLParser alloc] init];
        self.news = [[parser parserXMLFromData:(NSData *)newsObject] copy];
        for(FRNewsObject* item in self.news){
            item.isFavorite = [Utils isFavorite:item.guid withList:listFav];
            
        }

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
    } failure:^(NSInteger code,NSString *errorMess) {
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
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setLocale:[NSLocale currentLocale]];
        [dateFormat setDateFormat:@"EEE, d MMM yyyy HH:mm:ss ZZZ"];
        
        NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
        [dateFormat2 setLocale:[NSLocale currentLocale]];
        [dateFormat2 setDateFormat:@"HH:mm dd/MM/yyyy"];
        
        cell.dateLabel.text = [dateFormat2 stringFromDate:[dateFormat dateFromString:newsObj.pubDate]];
//        cell.thumbnailImageView.image = [UIImage imageNamed:@"husky.jpg"];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // retrive image on global queue
            UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:newsObj.urlImage]]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.thumbnailImageView.image = img;
            });
        });
        if (newsObj.isFavorite) {
            [cell.btn setTitle:@"Remove" forState:UIControlStateNormal];
        }else{
            [cell.btn setTitle:@"Add" forState:UIControlStateNormal];
        }
        
        
        cell.btn.tag = indexPath.row;

        [cell.btn addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
    }
    
}

- (void)buttonTapped:(id)sender {
    UIButton * cell = sender;
    FRNewsObject *item = [self.news objectAtIndex:cell.tag];
    NSLog(@"buttonTapped=>listFav(1)=%lu",[listFav count]);
    if([cell.titleLabel.text isEqualToString:@"Add"]) {
        if([[FRPostDAO sharedInstance] addFavoritePost:item] == YES){
            listFav = [[FRPostDAO sharedInstance] listAllFavorite];
            NSLog(@"buttonTapped=>listFav(2)=%lu",[listFav count]);
//            cell.enabled = NO;
            [cell setTitle:@"Remove" forState:UIControlStateNormal];
        }
    } else {
        if([[FRPostDAO sharedInstance] removeFavoriteNews:item] == YES){
            listFav = [[FRPostDAO sharedInstance] listAllFavorite];
            NSLog(@"buttonTapped=>listFav(2)=%lu",[listFav count]);
            [cell setTitle:@"Add" forState:UIControlStateNormal];
        }
    }
    NSLog(@"buttonTapped");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.news count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

@end