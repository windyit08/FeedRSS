//
//  ArticleTableViewCell.m
//  FeedRSS
//
//  Created by KinhNM1 on 9/3/15.
//  Copyright (c) 2015 KinhNM1. All rights reserved.
//

#import "ArticleTableViewCell.h"
#import "FRPost.h"

@interface ArticleTableViewCell()

@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@end

@implementation ArticleTableViewCell

//@synthesize thumbnailImageView = _thumbnailImageView;
//@synthesize titleLabel = _titleLabel;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configCellWithData:(FRPost *)article {
    
    self.titleLabel.text = @"Favorite";
    self.thumbnailImageView.contentMode = UIViewContentModeScaleToFill;
    self.thumbnailImageView.image = [UIImage imageNamed:@"husky.jpg"];
    
//
//    self.titleLabel.text = article.title;
//    self.thumbnailImageView.contentMode = UIViewContentModeScaleToFill;
//    
//    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:article.thumb]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//        self.thumbnailImageView.image = [UIImage imageWithData:data];
//    }];
}

@end
