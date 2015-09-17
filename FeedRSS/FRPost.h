//
//  FRPost.h
//  FeedRSS
//
//  Created by  TuanNKA on 9/17/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface FRPost : NSManagedObject

@property (nonatomic, retain) NSString * guid;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSDate * date;

@end
