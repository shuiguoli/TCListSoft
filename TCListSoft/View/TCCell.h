//
//  TCCell.h
//  TCListSoft
//
//  Created by 徐 哲 on 13-8-7.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCCell : UITableViewCell
@property (nonatomic, strong, readonly) UITextField *textField;
@property (nonatomic,assign) BOOL editingTextField;
+ (CGFloat)cellHeight;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setEditingAction:(SEL)editAction forTarget:(id)target;
@end
