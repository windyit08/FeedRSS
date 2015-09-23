//
//  FRAPIWorker.h
//  FeedRSS
//
//  Created by ThanhDM on 9/17/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FRAPIWorker : NSObject
+ (void)requestAPIAsync:(NSString *)stringURL
                success:(void (^)(id data))success
                failure:(void (^)(NSString *errorMessage))failure;

//+ (void)requestAuthAsync:(NSString *)stringURL
//              parameters:(id)parameters
//                 success:(void (^)(id data))success
//                 failure:(void (^)(NSString *errorMessage))failure;
//
//+ (void)requestAuthInfoAsync:(NSString *)stringURL
//                  parameters:(id)parameters
//                     success:(void (^)(id data))success
//                     failure:(void (^)(NSString *errorMessage))failure;
//
//+ (void)requestAPIGetAsync:(NSString *)stringURL
//                   success:(void (^)(id data))success
//                   failure:(void (^)(NSString *errorMessage))failure;
//+ (void)cancelAllOperations;
@end
