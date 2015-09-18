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
- (BOOL) addFavoritePost:(NSDictionary *) post;
- (BOOL) addFavoritePost:(NSString *) guid withTile:(NSString *) title withText:(NSString *) text withThumb:(NSString *) thumb;
- (BOOL) removeFavorite : (FRPost*) post;
- (NSMutableArray*) listAllFavorite;
- (void) populateWithDummies;
@end