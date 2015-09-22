//
//  CommonUtil.h
//  DDDUnitTestGuideline
//
//  Created by DucPV5 on 9/19/15.
//  Copyright (c) 2015 ddd69. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonUtil : NSObject

+(NSInteger)checkNetworkConnection; //0:OK | 1:error network
+(NSInteger)checkHost;
+(NSInteger)checkNetworkConnectionAndHost;

@end
