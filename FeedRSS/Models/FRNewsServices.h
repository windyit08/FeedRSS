//
//  FRNewsServices.h
//  FeedRSS
//
//  Created by ThanhDM on 9/16/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FRNewsObject.h"
#import "FRWebAPIError.h"
#import "HttpRequestService.h"

@interface FRNewsServices : NSObject

-(void)requestNewsList:(NSString *)urlNews
               success:(RequestSuccessBlock)success
               failure:(RequestFailureBlock)failure;
@end
