//
//  FRNewsModel.h
//  FeedRSS
//
//  Created by ThanhDM on 9/16/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FRNewsObject.h"
#import "FRWebAPIError.h"

@interface FRNewsModel : NSObject

-(void)requestNewsList:(NSString *)urlNews
               success:(void (^)(FRNewsObject *newsObject))success
               failure:(void (^)(NSString *errorMess))failure;
@end
