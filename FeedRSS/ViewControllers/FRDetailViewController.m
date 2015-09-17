//
//  FRDetailViewController.m
//  FeedRSS
//
//  Created by KinhNM1 on 9/16/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import "FRDetailViewController.h"

@interface FRDetailViewController ()

@end

@implementation FRDetailViewController
@synthesize web;
@synthesize Url;
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",Url);
    // Do any additional setup after loading the view.
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:Url]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
