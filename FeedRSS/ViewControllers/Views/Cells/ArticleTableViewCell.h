//
//  ArticleTableViewCell.h
//  FeedRSS
//
//  Created by KinhNM1 on 9/3/15.
//  Copyright (c) 2015 KinhNM1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FRBaseCell.h"

@class FRPost;

@interface ArticleTableViewCell : FRBaseCell

- (void)configCellWithData:(FRPost *)article;

@end