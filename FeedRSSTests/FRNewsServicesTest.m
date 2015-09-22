//
//  FRNewsModelTest.m
//  FeedRSS
//
//  Created by ThanhDM on 9/17/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FRNewsServices.h"
#import "XMLParser.h"
#import "CommonDefine.h"

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
    __block BOOL done = NO;
    XCTAssert(YES, @"Pass");
    NSLog(@"[FR][TEST] Start test example");
    NSString *homeNews = [NSString stringWithFormat:@"%@%@", BASE_URL,HOME_NEWS_CONTENT];
    FRNewsServices *newsServices = [[FRNewsServices alloc]init];
    [newsServices requestNewsList:homeNews success:^(id data) {
        //Handle object here
        NSLog(@"[FR][TEST] Success to get rss");
        NSLog(@"[FR][TEST] FRNewsModelTest: sucess here");
         XMLParser *parser = [[XMLParser alloc] init];
        NSArray *arrr =[[parser parserXMLFromData:(NSData *)data] copy];
        for(int i = 0; i < arrr.count; i++){
            FRNewsObject *frNew = [arrr objectAtIndex:i];
            XCTAssertNotNil(frNew); //Need assert not null
            XCTAssertTrue([frNew isKindOfClass:[FRNewsObject class]]); //Need assert item is in correct type

            NSLog(@"[FR][TEST] testFetchTopNews: (title %d) %@", i, frNew.title);
            NSLog(@"[FR][TEST] testFetchTopNews: (pubDate %d) %@", i, frNew.pubDate);
            NSLog(@"[FR][TEST] testFetchTopNews: (pubDate %d) %@", i, frNew.description);
        }
        done = YES;
    } failure:^(NSInteger errorCode, NSString *errorMsg) {
        NSLog(@"[FR][TEST]  Fail to get rss");
        NSLog(@"[FR][TEST] FRNewsModelTest: fail >> %@", errorMsg);
        done = YES;
    }];
    
    //To make unit test wait for function done
    while(!done) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
}

@end
