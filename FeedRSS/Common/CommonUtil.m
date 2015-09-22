//
//  CommonUtil.m
//  DDDUnitTestGuideline
//
//  Created by DucPV5 on 9/19/15.
//  Copyright (c) 2015 ddd69. All rights reserved.
//

#import "CommonUtil.h"
#import "Reachability.h"

@implementation CommonUtil

+(NSInteger)checkNetworkConnection;
{
    Reachability *reachInternet = [Reachability reachabilityForInternetConnection];
    NetworkStatus statusInternet = [reachInternet currentReachabilityStatus];
    if(statusInternet == NotReachable){
        return kInternetConnectionError;
    }
    return kInternetConnectionOK;
}

+(NSInteger)checkHost
{
    Reachability *reachHost = [Reachability reachabilityWithHostName:@"apple.com"];
    NetworkStatus statusHost = [reachHost currentReachabilityStatus];
    if(statusHost == NotReachable){
        return kInternetConnectionErrorHost;
    }
    return kInternetConnectionOK;
}

+(NSInteger)checkNetworkConnectionAndHost
{
    if ([self checkNetworkConnection] == NotReachable) {
        return kInternetConnectionError;
    }
    if ([self checkHost] == NotReachable) {
        return kInternetConnectionErrorHost;
    }
    return kInternetConnectionOK;
}

@end
