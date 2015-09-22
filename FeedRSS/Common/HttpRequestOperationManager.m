//
//  HttpRequestOperationManager.m
//  DDDUnitTestGuideline
//
//  Created by DucPV5 on 9/19/15.
//  Copyright (c) 2015 ddd69. All rights reserved.
//

#import "HttpRequestOperationManager.h"

static HttpRequestOperationManager *sharedInstance = nil;

@implementation HttpRequestOperationManager

+(HttpRequestOperationManager *) sharedInstance{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[HttpRequestOperationManager alloc]initWithBaseURL:nil];
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