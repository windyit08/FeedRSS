//
//  FRNewsServices.m
//  FeedRSS
//
//  Created by ThanhDM on 9/16/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import "FRNewsServices.h"
#import "FRNewsObject.h"
#import "HttpRequestService.h"
#import "AFNetworking.h"

@implementation FRNewsServices

-(void)requestNewsList:(NSString *)urlNews
               success:(RequestSuccessBlock)success
               failure:(RequestFailureBlock)failure{
    NSLog(@"[FR][requestNewsList] Start requestNewsList function with urlNews: %@", urlNews);
    [HttpRequestService getForObjectAsync:urlNews
                                   header:nil
                                parameter:nil
                                  success:^(id data) {
                                      success(data);
                                  }
                                  failure:failure];
    
}

@end
