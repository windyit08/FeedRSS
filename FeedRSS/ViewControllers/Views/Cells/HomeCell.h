//
//  SimpleTableCell.h
//  simpleKinhNM1
//
//  Created by KinhNM1 on 9/3/15.
//  Copyright (c) 2015 KinhNM1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FRBaseCell.h"

@interface HomeCell : FRBaseCell
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIButton *btn;
- (IBAction)onDelete:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
