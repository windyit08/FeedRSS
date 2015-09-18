//
//  FRFavoriteBusinessController.m
//  FeedRSS
//
//  Created by TCE on 9/18/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import "FRFavoriteBusinessController.h"
#import "FRArticleTableViewCell.h"
#import "FRPostDAO.h"
#import "FRPost.h"

@implementation FRFavoriteBusinessController

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = [[FRFavoriteDataSource alloc] init];
    }
    return self;
}

-(void)loadAllFavorites:(void(^)(void))success failure:(void (^)(NSString *errorMessage))failure {
    
    [self.dataSource loadAllFavorites:success failure:failure];
    
    /*
    //Call API
    //If OK
    self.dataSource.favorites = [NSArray arrayWithObjects:@"item 1", @"item2", nil];
    success();
    
    //If failed
    failure(@"Error message");
     */
}

- (NSString *)getSelectedUrl:(NSInteger)row {
    return [self.dataSource getSelectedArticle:row].guid;
}

@end

@implementation FRFavoriteDataSource

- (NSArray *)favoritesList {
    return self.favorites;
}

- (void)loadAllFavorites:(void(^)(void))success failure:(void (^)(NSString *errorMessage))failure {
    
    self.postDAO = [FRPostDAO sharedInstance];
    self.favorites = [self.postDAO listAllFavorite];
    
    if(self.favorites.count == 0) {
        [self.postDAO populateWithDummies];
        self.favorites = [self.postDAO listAllFavorite];
    }
    
    success();
}

- (FRPost *)getSelectedArticle:(NSInteger)row {
    return [self.favorites objectAtIndex:row];
}

#pragma mark - UITableViewDataSource methods

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier" forIndexPath:indexPath];
//    
//    cell.textLabel.text = self.favorites[indexPath.row];
//    return cell;
//}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIndentifier = @"FRArticleTableViewCell";
    FRArticleTableViewCell *cell = (FRArticleTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FRArticleTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    FRPost *article = [self.favorites objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = article.title;
    cell.thumbnailImageView.contentMode = UIViewContentModeScaleToFill;
    
    cell.thumbnailImageView.image = nil; // [UIImage imageNamed:@"default.png"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"HH:mm dd/MM/yyyy"];
    cell.pubDateLabel.text = [dateFormatter stringFromDate:article.date];
    
//    weak typeof(FRArticleTableViewCell)weakCell = cell;
//    
//    [cell.thumbnailImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:article.thumb]]
//                          placeholderImage:[UIImage imageNamed:@"img_loading.png"]
//                                   success:^(NSURLRequest request, NSHTTPURLResponse response, UIImage *image) {
//                                       weakCell.thumbnailImageView.image = image;
//                                       [weakCell setNeedsLayout];
//                                   } failure:^(NSURLRequest request, NSHTTPURLResponse response, NSError *error) {
//                                       weakCell.thumbnailImageView.image = [UIImage imageNamed:@"img_no_thumbnail.png"];
//                                   }];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // retrive image on global queue
        UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:article.thumb]]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            FRArticleTableViewCell * cell = (FRArticleTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            // assign cell image on main thread
            cell.thumbnailImageView.image = img;
        });
    });
    
//    
//    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:article.thumb]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//        cell.thumbnailImageView.image = [UIImage imageWithData:data];
//    }];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.favorites.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        if([self.postDAO removeFavorite:[self.favorites objectAtIndex:indexPath.row]]) {
            
            // Remove device from table view
            [self.favorites removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}

@end