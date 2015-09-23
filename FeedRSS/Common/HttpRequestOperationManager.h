//
//  HttpRequestOperationManager.h
//  DDDUnitTestGuideline
//
//  Created by DucPV5 on 9/19/15.
//  Copyright (c) 2015 ddd69. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface HttpRequestOperationManager : AFHTTPRequestOperationManager

+(HttpRequestOperationManager *) sharedInstance;

@end
