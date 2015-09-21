//
//  FetchArticleServices.h
//  FeedRSS
//
//  Created by ThanhDM on 9/16/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FRFetchArticleServices : NSObject
-(void)getListNewIt:(NSString *)urlNews
               success:(void (^)(NSMutableArray *listItem))success
               failure:(void (^)(NSString *errorMess))failure;
@end
