//
//  TCCell.m
//  TCListSoft
//
//  Created by 徐 哲 on 13-8-7.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import "TCCell.h"

@interface TCCell () <UIGestureRecognizerDelegate>

@property (nonatomic, strong, readonly) UITapGestureRecognizer *editingTapGestureRecognizer;
@end


@implementation TCCell

@synthesize editingTextField = _editingTextField;
@synthesize textField = _textField;
@synthesize editingTapGestureRecognizer = _editingTapGestureRecognizer;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if ((self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier]))
    {
		self.textLabel.textColor = [UIColor blackColor];
        
        
		UIView *background = [[UIView alloc] initWithFrame:CGRectZero];
		background.backgroundColor = [UIColor whiteColor];
		background.contentMode = UIViewContentModeRedraw;
		self.backgroundView = background;
		self.contentView.clipsToBounds = YES;
		
		_editingTapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
		_editingTapGestureRecognizer.delegate = self;
		[self addGestureRecognizer:_editingTapGestureRecognizer];
	}
	return self;
    
}

+ (CGFloat)cellHeight
{
    return 44.0f;
}
- (UITextField *)textField
{
	if (!_textField)
    {
		_textField = [[UITextField alloc] initWithFrame:CGRectZero];
		_textField.textColor = self.textLabel.textColor;
		_textField.backgroundColor = [UIColor whiteColor];
		_textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		_textField.returnKeyType = UIReturnKeyDone;
		_textField.alpha = 0.0f;
		_textField.font = [self.textLabel font];
		[self.contentView addSubview:_textField];
	}
	return _textField;
}


- (void)setEditingTextField:(BOOL)editingTextField
{
    _editingTextField = editingTextField;
	if (editingTextField)
    {
		[self.contentView addSubview:self.textField];
		[self setNeedsLayout];
		[_textField becomeFirstResponder];
        _textField.alpha = 1.0f;
	}
    else
    {
		[_textField resignFirstResponder];
		_textField.alpha = 0.0f;
		[_textField removeFromSuperview];
        _textField = nil;
	}
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	CGSize size = self.contentView.bounds.size;
	
	if (self.editing)
    {
		_textField.frame = CGRectMake(10.0f, 1.0f, size.width - 46.0f, size.height - 2.0f);
	}
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];
	if (!selected)
    {
		self.textLabel.backgroundColor = [UIColor whiteColor];
	}
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
	[super setEditing:editing animated:animated];
	_editingTapGestureRecognizer.enabled = editing;
//    [self setEditingTextField:editing];
}

- (void)prepareForReuse
{
	[super prepareForReuse];
	[self setEditing:NO];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
	return [touch.view isKindOfClass:[UIControl class]] == NO;
}


#pragma mark - Gesture Actions
- (void)setEditingAction:(SEL)editAction forTarget:(id)target
{
    [_editingTapGestureRecognizer addTarget:target action:editAction];
}

@end
