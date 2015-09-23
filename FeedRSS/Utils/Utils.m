//
//  Utils.m
//  FeedRSS
//
//  Created by KinhNM1 on 9/23/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+(BOOL) isFavorite:(NSString*) gui withList:(NSMutableArray*) list{
    for(NSString* ii in list){
        if([gui isEqualToString: ii]){
            return YES;
        }
    }
    return NO;
}

@end
