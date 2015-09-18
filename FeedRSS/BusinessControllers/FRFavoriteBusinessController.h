//
//  FRFavoriteBusinessController.h
//  FeedRSS
//
//  Created by TCE on 9/18/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FRFavoriteDataSource;

@interface FRFavoriteBusinessController : NSObject

@property (nonatomic, strong) FRFavoriteDataSource *dataSource;

-(void)loadAllFavorites:(void(^)(void))success failure:(void (^)(NSString *errorMessage))failure;

@end

@interface FRFavoriteDataSource : NSObject<UITableViewDataSource>

@property (nonatomic, strong) NSArray *favorites;

-(NSArray *)favoritesList;

@end