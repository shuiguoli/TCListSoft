//
//  TCItemPropertyCell.m
//  TCListSoft
//
//  Created by 徐 哲 on 13-8-6.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import "TCItemPropertyCell.h"
#import "TCItemProperty.h"
#import "TCDataStore.h"
#import "TCItem.h"
@interface TCItemPropertyCell()<UIGestureRecognizerDelegate>

@property (nonatomic, strong, readonly) UITapGestureRecognizer *editingTapGestureRecognizer;
@end


@implementation TCItemPropertyCell
{
    int itemCount;
}
@synthesize itemProperty = _itemProperty;
@synthesize createdItem = _createdItem;
@synthesize isInList = _isInList;
@synthesize countView = _countView;
@synthesize delegate = _delegate;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    debugMethod();//删除
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UIImageView *disclosureImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 10.0f, 15.0f)];
		disclosureImageView.image = [UIImage imageNamed:@"460.jpg"];
		self.accessoryView = disclosureImageView;
        
        UIView *selectedBackground = [[UIView alloc] initWithFrame:CGRectZero];
		selectedBackground.backgroundColor = [UIColor colorWithRed:0.0f green:0.502f blue:0.725f alpha:1.0f];
		selectedBackground.contentMode = UIViewContentModeRedraw;
		self.selectedBackgroundView = selectedBackground;
        
    }
    return self;
}

- (UIView*)countView
{
    debugMethod();//删除
    if(_countView == nil)
    {
#warning 后期需要修改
        _countView = [[UISlider alloc] initWithFrame:CGRectMake(100, 10, 150, 31)];
        [_countView setMinimumValue:0.0f];
        [_countView setMaximumValue:10.0f];
        [_countView setValue:0.0f];
        [_countView addTarget:self action:@selector(updateCount) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_countView];
    }
    return _countView;

}
- (void)showCountView:(BOOL)show
{
    debugMethod();//删除
    if(show)
        NSLog(@"show countView");
    self.countView.hidden = !show;
    if(show == NO && (int)self.countView.value != 0)
    {
        [self setEditing:NO];
        if([self.delegate respondsToSelector:@selector(newSelectItemProperty:withCount:)])
        {
            [self.delegate newSelectItemProperty:[self itemProperty] withCount:_countView.value];
        }
        else
        {
            debugMethod();
            debugLog(@"delegate is not is itempropertycellDelegate");
        }
    }
}
- (void)updateCount
{
    debugMethod();//删除
    itemCount = _countView.value;
}

- (void)setItemProperty:(TCItemProperty *)itemProperty
{
    debugMethod();//删除
    _itemProperty = itemProperty;
    self.textLabel.text = itemProperty.name;
    [self setNeedsLayout];
}

- (void)setEditingTextField:(BOOL)editingTextField
{
    if(editingTextField)
    {
        [self showCountView:NO];
        self.textField.text = self.itemProperty.name;
    }
    [super setEditingTextField:editingTextField];
    debugMethod();//删除
    
}

@end
