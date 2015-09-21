//
//  FRNewsModelTest.m
//  FeedRSS
//
//  Created by ThanhDM on 9/17/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FRNewsModel.h"
#import "XMLParser.h"

@interface FRNewsModelTest : XCTestCase

@end

@implementation FRNewsModelTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
    FRNewsModel *newsModel = [[FRNewsModel alloc] init];
    NSLog(@"[FR] Start test example");
    [newsModel requestNewsList:@"http://vnexpress.net/rss/tin-moi-nhat.rss" success:^(FRNewsObject *newsObject) {
        //Handle object here
        NSLog(@"[FR] Success to get rss");
        NSLog(@"FRNewsModelTest: sucess here");
         XMLParser *parser = [[XMLParser alloc] init];
        NSArray *arrr =[[parser parserXMLFromData:(NSData *)newsObject] copy];
        for(int i = 0; i < arrr.count; i++){
            FRNewsObject *frNew = [arrr objectAtIndex:i];
            XCTAssertNotNil(frNew); //Need assert not null
            XCTAssertTrue([frNew isKindOfClass:[FRNewsObject class]]); //Need assert item is in correct type

            NSLog(@"testFetchTopNews: (title %d) %@", i, frNew.title);
            NSLog(@"testFetchTopNews: (pubDate %d) %@", i, frNew.pubDate);
             NSLog(@"testFetchTopNews: (pubDate %d) %@", i, frNew.description);
        }
    } failure:^(NSString *errorMess) {
        NSLog(@"[FR] Fail to get rss");
        NSLog(@"FRNewsModelTest: fail >> %@", errorMess);
    }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
}

@end
