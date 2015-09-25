//
//  FRFavoriteBusinessController.m
//  FeedRSS
//
//  Created by TCE on 9/18/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import "FRITBusinessController.h"
#import "HomeCell.h"
#import "FRFetchArticleServices.h"
#import "FRNewsObject.h"
#import "FRPostDAO.h"
#import "FRPost.h"
#import "Utils.h"

@implementation FRITBusinessController

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = [[FRITDataSource alloc] init];
    }
    return self;
}

-(void)loadAllNews:(void(^)(void))success failure:(void (^)(NSString *errorMessage))failure {
    
    [self.dataSource loadAllNews:success failure:failure];
    
    /*
    //Call API
    //If OK
    self.dataSource.news = [NSArray arrayWithObjects:@"item 1", @"item2", nil];
    success();
    
    //If failed
    failure(@"Error message");
     */
    
}

@end




#pragma mark - FRHomeDataSource

@implementation FRITDataSource{
    NSString *IT_NEWS_URL;
    NSMutableArray* listFav;
}



- (NSArray *)newsList {
    return self.news;
}

- (void)loadAllNews:(void(^)(void))success failure:(void (^)(NSString *errorMessage))failure {

    listFav = [[FRPostDAO sharedInstance] listAllGuiOfFavorite];
    NSLog(@"loadAllNews=>listFav=%lu",[listFav count]);

    IT_NEWS_URL =[NSString stringWithFormat:@"%@%@", BASE_URL,IT_NEWS_CONTENT];
    self.frFetchArticleServices = [[FRFetchArticleServices alloc]init];
    [ self.frFetchArticleServices getListNewIt:IT_NEWS_URL success:^(NSMutableArray *listItem) {
        self.news = listItem;
        for(FRNewsObject* item in self.news){
            item.isFavorite = [Utils isFavorite:item.guid withList:listFav];
           
        }
        success();
    } failure:^(NSString *errorMess) {
        NSLog(@"fail call api");
    }];
}

#pragma mark - UITableViewDataSource methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    {
        HomeCell * cell = nil;
        
        static NSString *simpleTableIndentifier = @"HomeCell";
        
        
        cell = (HomeCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIndentifier];
        
        if(cell == nil){
            
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HomeCell" owner:self options:nil];
            
            cell = [nib objectAtIndex:0];
            
        }
        FRNewsObject *item = [self.news objectAtIndex:indexPath.row];
        //FRPost *post = [posts objectAtIndex:indexPath.row];
        //cell.nameLabel.text = post.title;
        cell.nameLabel.text = item.title;
        cell.dateLabel.text = item.pubDate;
        //cell.thumbnailImageView.contentMode = UIViewContentModeScaleToFill;
//        cell.thumbnailImageView.image = [UIImage imageNamed:@"husky.jpg"];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // retrive image on global queue
            UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:item.urlImage]]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.thumbnailImageView.image = img;
            });
        });

        if (item.isFavorite) {
              cell.btn.enabled = NO;
        }else{
            cell.btn.enabled = YES;
        }
        
         [cell.btn addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        cell.btn.tag = indexPath.row;
        return cell;
        
    }
    
}



- (void)buttonTapped:(id)sender {
    UIButton * cell = sender;
    FRNewsObject *item = [self.news objectAtIndex:cell.tag];
    NSLog(@"buttonTapped=>listFav(1)=%lu",[listFav count]);
    if([[FRPostDAO sharedInstance] addFavoritePost:item] == YES){
        listFav = [[FRPostDAO sharedInstance] listAllFavorite];
        NSLog(@"buttonTapped=>listFav(2)=%lu",[listFav count]);
        cell.enabled = NO;
    }
    NSLog(@"buttonTapped");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.news.count;
    //return 100;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

@end