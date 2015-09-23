//
//  FetchArticleServices.m
//  FeedRSS
//
//  Created by ThanhDM on 9/16/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import "FRFetchArticleServices.h"
#import "FRNewsObject.h"
#import "FRNewsServices.h"
#import "XMLParser.h"
@implementation FRFetchArticleServices

- (void)getListNewIt:(NSString *)urlNews success:(void (^)(NSMutableArray *))success failure:(void (^)(NSString *))failure {
    FRNewsServices *newsModel = [[FRNewsServices alloc] init];
    
    [newsModel requestNewsList:urlNews success:^(FRNewsObject *newsObject) {
        XMLParser *parser = [[XMLParser alloc]init];
        NSMutableArray *result = [[parser parserXMLFromData:(NSData *)newsObject] copy];
        success(result);
    } failure:^(NSInteger errorCode,NSString *errorMess) {
        NSLog(@"[FR] Fail to get rss");
        NSLog(@"FRNewsModelTest: fail >> %@", errorMess);
        failure(errorMess);
    }];
}

@end
