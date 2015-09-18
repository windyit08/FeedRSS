//
//  FRFavoriteBusinessController.m
//  FeedRSS
//
//  Created by TCE on 9/18/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import "FRFavoriteBusinessController.h"
//#import "FRPost.h"

@implementation FRFavoriteBusinessController

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = [[FRFavoriteDataSource alloc] init];
    }
    return self;
}

-(void)loadAllFavorites:(void(^)(void))success failure:(void (^)(NSString *errorMessage))failure
{
    //Call API
    //If OK
    self.dataSource.favorites = [NSArray arrayWithObjects:@"item 1", @"item2", nil];
    success();
    
    //If failed
    failure(@"Error message");
    
}

@end

@implementation FRFavoriteDataSource

-(NSArray *)favoritesList
{
    return self.favorites;
}

#pragma mark - UITableViewDataSource methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier" forIndexPath:indexPath];
    
    cell.textLabel.text = self.favorites[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.favorites.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

@end