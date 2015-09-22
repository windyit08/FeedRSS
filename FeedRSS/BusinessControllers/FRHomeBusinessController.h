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

typedef void(^SuccessBlock)(id data);
typedef void(^FailureBlock)(NSInteger errorCode, NSString *errorMsg);
@property (nonatomic, strong) NSArray *newsArray;
@property (nonatomic, strong) FRHomeDataSource *dataSource;
- (void)loadAllNews:(SuccessBlock)success failure:(FailureBlock)failure;

@end

@interface FRHomeDataSource : NSObject<UITableViewDataSource>

typedef void(^SuccessBlock)(id data);
typedef void(^FailureBlock)(NSInteger errorCode, NSString *errorMsg);
@property (nonatomic, strong) NSMutableArray *news;
@property (nonatomic, strong) NSArray *newsList;
-(void)loadAllNews:(SuccessBlock)success failure:(FailureBlock)failure;

@end