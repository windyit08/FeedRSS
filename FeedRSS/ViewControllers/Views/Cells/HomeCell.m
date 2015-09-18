//
//  SimpleTableCell.m
//  simpleKinhNM1
//
//  Created by KinhNM1 on 9/3/15.
//  Copyright (c) 2015 KinhNM1. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell
@synthesize nameLabel = _nameLabel;

@synthesize thumbnailImageView = _thumbnailImageView;
@synthesize dateLabel;


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onDelete:(id)sender {
    
}
@end
