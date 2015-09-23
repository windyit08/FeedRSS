//
//  FRNewsObject.h
//  FeedRSS
//
//  Created by ThanhDM on 9/16/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FRNewsObject : NSObject

@property(nonatomic, copy)NSString* title;
@property(nonatomic, copy)NSString* description;
@property(nonatomic, copy)NSString* pubDate;
@property(nonatomic, copy)NSString* link;
@property(nonatomic, copy)NSString* guid;
@property(nonatomic, copy)NSString* slash;
@property(nonatomic, copy)NSString* urlImage;
@property(nonatomic) bool isFavorite;


@end
