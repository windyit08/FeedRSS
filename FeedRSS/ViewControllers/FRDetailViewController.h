//
//  FRDetailViewController.h
//  FeedRSS
//
//  Created by KinhNM1 on 9/16/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FRDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *web;
@property (nonatomic, strong) NSString *Url;

@end
