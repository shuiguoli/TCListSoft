//
//  TCAddItemPropertyCell.m
//  TCListSoft
//
//  Created by 徐 哲 on 13-8-8.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import "TCAddItemPropertyCell.h"

@implementation TCAddItemPropertyCell

@synthesize closeButton = _closeButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *background = [[UIView alloc] initWithFrame:CGRectZero];
		background.backgroundColor = [UIColor whiteColor];
		background.contentMode = UIViewContentModeRedraw;
		self.backgroundView = background;
		self.contentView.clipsToBounds = YES;
        
        self.closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 40.0f, 51.0f)];
		[self.closeButton setImage:[UIImage imageNamed:@"x"] forState:UIControlStateNormal];
		self.accessoryView = self.closeButton;
        
    }
    return self;
}

-(UITextField*)textField
{
    if (!_textField)
    {
		_textField = [[UITextField alloc] initWithFrame:CGRectZero];
		_textField.textColor = [UIColor blackColor];
        _textField.font = [UIFont systemFontOfSize:18.0];
        _textField.backgroundColor = [UIColor whiteColor];
		_textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		_textField.returnKeyType = UIReturnKeyDone;
        _textField.placeholder = @"Name your item";
        _textField.autocapitalizationType = UITextAutocapitalizationTypeWords;

		_textField.alpha = 1.0f;
		[self.contentView addSubview:_textField];
	}
	return _textField;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
    
	CGSize size = self.contentView.bounds.size;
	self.textField.frame = CGRectMake(10.0f, 1.0f, size.width - 20.0f, size.height - 2.0f);
}

//- (void) setEditing:(BOOL)editing animated:(BOOL)animated
//{
//    [super setEditing:editing animated:animated];
//}

+ (CGFloat)cellHeight
{
    return 44.0f;
}

@end
