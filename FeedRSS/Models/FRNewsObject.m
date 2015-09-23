//
//  FRNewsObject.m
//  FeedRSS
//
//  Created by ThanhDM on 9/16/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import "FRNewsObject.h"

@implementation FRNewsObject

@synthesize title = _title;
@synthesize description = _description;
@synthesize pubDate = _pubDate;
@synthesize link = _link;
@synthesize guid = _guid;
@synthesize slash = _slash;


-(void) dealloc{
    
    self.title = nil;
    self.description = nil;
    self.pubDate = nil;
    self.link = nil;
    self.guid = nil;
    self.slash = nil;
    
//    [super dealloc];
    
}

@end
