//
//  XMLParser.h
//  FeedRSS
//
//  Created by HiepLT1 on 9/18/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FRNewsObject.h"
@interface XMLParser : NSObject 

-(NSArray *)parserXMLFromData:(NSData *)data;
@end
