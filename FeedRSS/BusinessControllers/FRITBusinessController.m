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

@implementation FRITDataSource

- (NSArray *)newsList {
    return self.news;
}

- (void)loadAllNews:(void(^)(void))success failure:(void (^)(NSString *errorMessage))failure {

    self.frFetchArticleServices = [[FRFetchArticleServices alloc]init];
    NSString *url = @"http://vnexpress.net/rss/so-hoa.rss";
    [ self.frFetchArticleServices getListNewIt:url success:^(NSMutableArray *listItem) {
        self.news = listItem;
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
        //cell.thumbnailImageView.contentMode = UIViewContentModeScaleToFill;
        cell.thumbnailImageView.image = [UIImage imageNamed:@"husky.jpg"];
        
        return cell;
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return self.news.count;
    return 100;
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