//
//  FRHTTPRequestOperationManager.h
//  FeedRSS
//
//  Created by ThanhDM on 9/17/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

@interface FRHTTPRequestOperationManager : AFHTTPRequestOperationManager

+(FRHTTPRequestOperationManager*)sharedInstance;

@end
