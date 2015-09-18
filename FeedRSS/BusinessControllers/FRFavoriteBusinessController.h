//
//  FRFavoriteBusinessController.h
//  FeedRSS
//
//  Created by TCE on 9/18/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FRFavoriteDataSource;
@class FRPostDAO;

@interface FRFavoriteBusinessController : NSObject

@property (nonatomic, strong) FRFavoriteDataSource *dataSource;

- (void)loadAllFavorites:(void(^)(void))success failure:(void (^)(NSString *errorMessage))failure;

@end

@interface FRFavoriteDataSource : NSObject<UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *favorites;
@property (retain, nonatomic) FRPostDAO *postDAO;

- (NSArray *)favoritesList;
-(void)loadAllFavorites:(void(^)(void))success failure:(void (^)(NSString *errorMessage))failure;

@end