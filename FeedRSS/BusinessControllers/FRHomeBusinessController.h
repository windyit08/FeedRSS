//
//  FRFavoriteBusinessController.h
//  FeedRSS
//
//  Created by TCE on 9/18/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FRHomeDataSource;


@interface FRHomeBusinessController : NSObject

@property (nonatomic, strong) NSArray *newsArray;
@property (nonatomic, strong) FRHomeDataSource *dataSource;
- (void)loadAllNews:(void(^)(void))success failure:(void (^)(NSString *errorMessage))failure;

@end

@interface FRHomeDataSource : NSObject<UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *news;
@property (nonatomic, strong) NSArray *newsList;
-(void)loadAllNews:(void(^)(void))success failure:(void (^)(NSString *errorMessage))failure;

@end