//
//  XMLParser.m
//  FeedRSS
//
//  Created by HiepLT1 on 9/18/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import "XMLParser.h"
#import "FRNewsObject.h"

@interface XMLParser ()<NSXMLParserDelegate>{
    BOOL _accumulatingParsedCharacterData;
}

@property (nonatomic) NSMutableArray *currentParseBatch;
@property (nonatomic) FRNewsObject *currentParseObject;
@property (nonatomic) NSMutableString *currentParsedCharacterData;

@end

static FRNewsObject *sharedInstance = nil;
@implementation XMLParser

+ (FRNewsObject *) sharedInstance{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[FRNewsObject alloc]init];
    });
    return sharedInstance;
}

-(instancetype)init{
    if (sharedInstance) {
        [NSException raise:@"bug" format:@"tried to create more than one instance"];
    }
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(NSArray *)parserXMLFromData:(NSData *)data{
    NSXMLParser *xmlParser = (NSXMLParser *)data;
    if(xmlParser!=nil){
        [xmlParser setDelegate:self];
        [xmlParser parse];
    }
    NSArray *arr = [_currentParseBatch copy];
    return arr;
}

-(void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    _currentParsedCharacterData = [[NSMutableString alloc] init];
}

-(void)parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    if([elementName isEqualToString:@"channel"]){//Create list
        if(_currentParseBatch){
            _currentParseBatch = nil;
        }
        _currentParseBatch = [[NSMutableArray alloc]init];
    }else if([elementName isEqualToString:@"item"]){
        //Create object item
        _currentParseObject = [[FRNewsObject alloc]init];
    }else if([elementName isEqualToString:@"title"]){
        if(_currentParsedCharacterData){
            [_currentParsedCharacterData setString:@""];
        }
        _accumulatingParsedCharacterData = YES;
    }else if([elementName isEqualToString:@"description"]){
        if(_currentParsedCharacterData){
            [_currentParsedCharacterData setString:@""];
        }
        _accumulatingParsedCharacterData = YES;
    }else if([elementName isEqualToString:@"pubDate"]){
        if(_currentParsedCharacterData){
            [_currentParsedCharacterData setString:@""];
        }
        _accumulatingParsedCharacterData = YES;
    }else if([elementName isEqualToString:@"link"]){
        if(_currentParsedCharacterData){
            [_currentParsedCharacterData setString:@""];
        }
        _accumulatingParsedCharacterData = YES;
    }else if([elementName isEqualToString:@"guid"]){
        if(_currentParsedCharacterData){
            [_currentParsedCharacterData setString:@""];
        }
        _accumulatingParsedCharacterData = YES;
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"channel"]){//End list
        
    }else if([elementName isEqualToString:@"item"]){//Add object item to list
        [_currentParseBatch addObject:_currentParseObject];
    }else if([elementName isEqualToString:@"title"]){
        _currentParseObject.title = _currentParsedCharacterData;
    }else if([elementName isEqualToString:@"description"]){
//        _currentParseObject.description = _currentParsedCharacterData;
        [self parser:parser foundCDATA:[_currentParsedCharacterData dataUsingEncoding:NSUTF8StringEncoding]];
    }else if([elementName isEqualToString:@"pubDate"]){
        _currentParseObject.pubDate = _currentParsedCharacterData;
    }else if([elementName isEqualToString:@"link"]){
        _currentParseObject.link = _currentParsedCharacterData;
    }else if([elementName isEqualToString:@"guid"]){
        _currentParseObject.guid = _currentParsedCharacterData;
    }
    
    _accumulatingParsedCharacterData = NO;
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (_accumulatingParsedCharacterData) {
        [_currentParsedCharacterData appendString:string];
    }
}
-(void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
{
    NSString *someString = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
    
    [_currentParsedCharacterData appendString:someString];
    
    NSString *imageURLString = [self getUrlImages:someString];
    NSURL *imageURL = [NSURL URLWithString:imageURLString];
    _currentParseObject.urlImage = [imageURL absoluteString];;
    
}
-(NSString *) getUrlImages:(NSString *)url{
    NSScanner *theScanner;
    NSString *imageURL = nil;
    
    theScanner = [NSScanner scannerWithString: url];
    
    // find start of tag
    [theScanner scanUpToString: @"<img" intoString: NULL];
    if ([theScanner isAtEnd] == NO) {
        
        [theScanner scanUpToString: @"src=\"" intoString: NULL];
        NSInteger newLoc2 = [theScanner scanLocation] + 5;
        [theScanner setScanLocation: newLoc2];
        
        // find end of tag
        [theScanner scanUpToString: @"\"" intoString: &imageURL];
    }
    return imageURL;
}
@end
