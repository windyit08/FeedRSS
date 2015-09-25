//
//  FRPostDAO.h
//  FeedRSS
//
//  Created by  TuanNKA on 9/17/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

@class FRPost;
@class FRNewsObject;

@interface FRPostDAO : NSObject
+ (instancetype)sharedInstance;
- (BOOL) addFavoritePost:(FRNewsObject *) news;
- (BOOL) addFavoritePost:(NSString *) guid withTile:(NSString *) title withText:(NSString *) text withThumb:(NSString *) thumb withDate:(NSString *)date;
- (BOOL) removeFavorite : (FRPost*) post;
- (BOOL) removeFavoriteNews : (FRNewsObject*) news;
- (NSMutableArray*) listAllFavorite;
- (NSMutableArray*) listAllGuiOfFavorite;
- (void) populateWithDummies;
@end