//
//  HttpRequestService.h
//  DDDUnitTestGuideline
//
//  Created by DucPV5 on 9/19/15.
//  Copyright (c) 2015 ddd69. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RequestSuccessBlock)(id data);
typedef void(^RequestFailureBlock)(NSInteger errorCode, NSString *errorMsg);

@interface HttpRequestService : NSObject

+(void)postForObjectAsync:(NSString *)stringURL
                   header:(NSDictionary *)header
                parameter:(NSDictionary *)parameters
                  success:(RequestSuccessBlock)success
                  failure:(RequestFailureBlock)failure;

+(void)getForObjectAsync:(NSString *)stringURL
                  header:(NSDictionary *)header
               parameter:(NSDictionary *)parameters
                 success:(RequestSuccessBlock)success
                 failure:(RequestFailureBlock)failure;

+(void)cancelAllRequest;

@end
