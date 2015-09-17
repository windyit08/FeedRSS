//
//  FRAPIWorker.m
//  FeedRSS
//
//  Created by ThanhDM on 9/17/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import "FRAPIWorker.h"
#import "FRHTTPRequestOperationManager.h"
#import "FRWebAPIError.h"

@implementation FRAPIWorker

NSString * const APIKEY_RETURNCODE = @"returnCode";
NSString * const RESPONSE_ERROR_CONNECTION_FAILED = @"Connection failed!";

+(void)startRequest:(NSMutableURLRequest *)request
            success:(void (^)(id data))success
            failure:(void (^)(NSString *errorMessage))failure{
    FRHTTPRequestOperationManager *manager = [FRHTTPRequestOperationManager sharedInstance];
    AFHTTPRequestOperation* operation = [manager HTTPRequestOperationWithRequest:request
                                                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                             NSLog(@"RESPONSE XML: %@", responseObject);
                                                                             if (responseObject) {
                                                                                 NSInteger returnedCode = 0;
                                                                                 if ([responseObject objectForKey:APIKEY_RETURNCODE]) {
                                                                                     returnedCode = [[responseObject objectForKey:APIKEY_RETURNCODE]integerValue];
                                                                                 }
                                                                             }
                                                                             success(responseObject);
                                                                         }
                                                                         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                             NSLog(@"Error: %@", error);
                                                                             if ([operation isCancelled]) {
                                                                                 NSLog(@"REQUEST %@ is CANCELLED", request.URL);
                                                                                 return;
                                                                             }
                                                                             failure(RESPONSE_ERROR_CONNECTION_FAILED);
                                                                         }];
    
    [manager.operationQueue addOperation:operation];
}

+ (void)requestAPIAsync:(NSString *)stringURL
                success:(void (^)(id data))success
                failure:(void (^)(NSString *errorMessage))failure
{
    //Check internet and host
    //    if([ATVCommonUtil isMainThread]){
    //        NSLog(@"requestAuthInfoAsync in main thread");
    //    }
    
    //    NSInteger connStatus = [ATVCommonUtil checkConnection];
    //    if(connStatus != connectionOK){
    //        NSString *errorMessage = nil;
    //        if(connStatus == connectionErrorHost){
    //            errorMessage = RESPONSE_ERROR_HOST;
    //        }
    //        else errorMessage = RESPONSE_ERROR_NOINTERNET;
    //        failure(errorMessage);
    //        return;
    //    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringURL]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/xml; charset=utf-8" forHTTPHeaderField:@"Accept"];
    NSLog(@"REQUEST: %@", stringURL);
    [self startRequest:request success:success failure:failure];
}

@end
