//
//  FRFavoriteBusinessController.h
//  FeedRSS
//
//  Created by TCE on 9/18/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FRITDataSource;
@class FRPostDAO;

@interface FRITBusinessController : NSObject

@property (nonatomic, strong) FRITDataSource *dataSource;

- (void)loadAllNews:(void(^)(void))success failure:(void (^)(NSString *errorMessage))failure;

@end

@interface FRITDataSource : NSObject<UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *news;
@property (retain, nonatomic) FRPostDAO *postDAO;

- (NSArray *)newsList;
-(void)loadAllNews:(void(^)(void))success failure:(void (^)(NSString *errorMessage))failure;

@end