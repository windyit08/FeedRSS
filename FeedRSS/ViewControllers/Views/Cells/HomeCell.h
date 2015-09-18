//
//  SimpleTableCell.h
//  simpleKinhNM1
//
//  Created by KinhNM1 on 9/3/15.
//  Copyright (c) 2015 KinhNM1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FRBaseCell.h"

@interface SimpleTableCell : FRBaseCell
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;


@end
