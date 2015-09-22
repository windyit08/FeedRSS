//
//  FRCommonUtils.h
//  FeedRSS
//
//  Created by TCE on 9/15/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FRCommonUtils : NSObject

+(NSString *)appVersion;
+(NSString *)platformString;
+(BOOL)isiOS8later;

@end
