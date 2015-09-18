//
//  FRFavoriteViewController.h
//  FeedRSS
//
//  Created by KinhNM1 on 9/16/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FRPostDAO.h"

@interface FRFavoriteViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic, strong) NSMutableArray *posts;
@property (retain, nonatomic) FRPostDAO *postDAO;
@end
