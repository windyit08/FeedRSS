//
//  FRPostDAO.h
//  FeedRSS
//
//  Created by  TuanNKA on 9/17/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

@class FRPost;

@interface FRPostDAO : NSObject
+ (instancetype)sharedInstance;
- (void) addFavoritePost:(NSDictionary *) post;
- (void) addFavoritePost:(NSString *) guid withTile:(NSString *) title withText:(NSString *) text withThumb:(NSString *) thumb;
- (void) removeFavorite : (FRPost*) post;

@end