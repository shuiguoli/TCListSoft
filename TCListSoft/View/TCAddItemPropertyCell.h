//
//  TCAddItemPropertyCell.h
//  TCListSoft
//
//  Created by 徐 哲 on 13-8-8.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import "TCCell.h"

@interface TCAddItemPropertyCell : UITableViewCell
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UIButton *closeButton;

+ (CGFloat)cellHeight;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end

