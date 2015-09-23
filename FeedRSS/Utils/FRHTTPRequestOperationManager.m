//
//  FRHTTPRequestOperationManager.m
//  FeedRSS
//
//  Created by ThanhDM on 9/17/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import "FRHTTPRequestOperationManager.h"

@implementation FRHTTPRequestOperationManager

static FRHTTPRequestOperationManager *sharedInstance = nil;

+(FRHTTPRequestOperationManager*)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[FRHTTPRequestOperationManager alloc]initWithBaseURL:nil];
    });
    return sharedInstance;
}

-(instancetype)initWithBaseURL:(NSURL *)url
{
    if(sharedInstance) {
        // avoid creating more than one instance
        [NSException raise:@"bug" format:@"tried to create more than one instance"];
    }
    
    self = [super initWithBaseURL:url];
    if(self){
        
    }
    return self;
}


@end
