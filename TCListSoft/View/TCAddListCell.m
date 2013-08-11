//
//  TCAddListTableViewCell.m
//  TCListSoft
//
//  Created by 徐 哲 on 13-8-5.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import "TCAddListCell.h"

@implementation TCAddListCell

@synthesize cellTextField,cellImage;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
