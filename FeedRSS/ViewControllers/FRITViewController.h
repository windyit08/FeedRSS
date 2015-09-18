//
//  FRHomeViewController.h
//  FeedRSS
//
//  Created by KinhNM1 on 9/18/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FRITViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;

@end
