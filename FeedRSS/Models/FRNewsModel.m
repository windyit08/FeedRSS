//
//  FRNewsModel.m
//  FeedRSS
//
//  Created by ThanhDM on 9/16/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import "FRNewsModel.h"
#import "FRNewsObject.h"
#import "FRWebAPIError.h"
#import "FRAPIWorker.h"
#import "FRHTTPRequestOperationManager.h"
#import "AFNetworking.h"

@implementation FRNewsModel

#define BASE_URL = @"http://vnexpress.net/";
#define HOME_NEWS_CONTENT = @"rss/tin-moi-nhat.rss";

-(void)requestNewsList:(NSString *)urlNews
               success:(void (^)(FRNewsObject *newsObject))success
               failure:(void (^)(NSString *errorMessage))failure{
    NSLog(@"[FR][requestNewsList] Start requestNewsList function with urlNews: %@", urlNews);
    [FRAPIWorker requestAPIAsync:urlNews success:success failure:failure];
    
}

@end
