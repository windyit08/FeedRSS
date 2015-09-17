//
//  FRPostDAO.m
//  FeedRSS
//
//  Created by  TuanNKA on 9/17/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import "FRPostDAO.h"
#import "FRPost.h"

@implementation FRPostDAO: NSObject

+ (instancetype)sharedInstance {
    static FRPostDAO *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[FRPostDAO alloc] init];
    });
    return _instance;
}

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void) addFavoritePost:(NSDictionary *)post {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *postRss = [NSEntityDescription insertNewObjectForEntityForName:@"FRPost" inManagedObjectContext:context];
    [postRss setValue:post[@"guid"] forKey:@"guid"];
    [postRss setValue:post[@"title"] forKey:@"title"];
    [postRss setValue:post[@"text"] forKey:@"text"];
    [postRss setValue:post[@"thumb"] forKey:@"thumb"];
    [postRss setValue:[NSDate date] forKey:@"date"];
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Insert! %@ %@", error, [error localizedDescription]);
        return;
    }
}

- (void) addFavoritePost:(NSString *)guid withTile:(NSString *)title withText:(NSString *)text withThumb:(NSString *)thumb {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *post = [NSEntityDescription insertNewObjectForEntityForName:@"FRPost" inManagedObjectContext:context];
    [post setValue:guid forKey:@"guid"];
    [post setValue:title forKey:@"title"];
    [post setValue:text forKey:@"text"];
    [post setValue:[NSDate date] forKey:@"date"];
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Insert! %@ %@", error, [error localizedDescription]);
        return;
    }
}

- (void) removeFavorite:(FRPost *)post {
    NSManagedObjectContext *context = [self managedObjectContext];
    [context deleteObject:post];
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
        return;
    }
}

@end
