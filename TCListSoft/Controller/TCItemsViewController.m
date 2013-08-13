
//
//  TCItemsViewController.m
//  TCListSoft
//
//  Created by 徐 哲 on 13-8-1.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import "TCItemsViewController.h"
#import "TCDataStore.h"
#import "TCItem.h"
#import "TCItemProperty.h"
#import "PKRevealController.h"
#import "TCList.h"
#import "TCItemPropertyCell.h"
#import "TCAddListViewController.h"
#import "TCAppDelegate.h"
#import "TCAddItemPropertyCell.h"
#import "UIScrollView+SSToolkitAdditions.h"
@interface TCItemsViewController ()
{
    UITapGestureRecognizer *_tableViewTapGestureRecognizer;
    BOOL canEditing;
    BOOL _adding;
    BOOL _allowScrolling;
    NSMutableArray *selectedItemPropertys;
    NSIndexPath *selectedIndexPath;
    
}
@property (nonatomic,strong) NSMutableArray *newSelectedItemPropertys;
-(void)_addNewItem;
@end

@implementation TCItemsViewController

@synthesize coverView = _coverView;
@synthesize addToList = _addToList;
@synthesize delegate;
@synthesize displayMode = _displayMode;
@synthesize newSelectedItemPropertys = _newSelectedItemPropertys;
- (id)initWithSytle:(UITableViewStyle)style andDisplayMode:(TCItemsDisplayMode)mode
{
    self = [super initWithStyle:style];
    if(self)
    {
        _displayMode = mode;
        UINavigationItem *n = [self navigationItem];
        [n setTitle:@"清单库"];
        if(mode == TCItemDisplayShowMode)
        {
            UIImage *revealImagePortrait = [UIImage imageNamed:@"reveal_menu_icon_portrait"];
            UIImage *revealImageLandscape = [UIImage imageNamed:@"reveal_menu_icon_landscape"];
            UINavigationItem *n = [self navigationItem];
            
            UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:revealImagePortrait landscapeImagePhone:revealImageLandscape style:UIBarButtonItemStylePlain target:self action:@selector(showLeftView:)];
            [n setLeftBarButtonItem:leftItem animated:YES];
        }
        if(mode == TCItemDisplayAddToListMode)
        {
            
        }
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //设置在编辑状态点击其他位置，取消编辑
    _tableViewTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endCellEditing)];
	_tableViewTapGestureRecognizer.enabled = NO;
	_tableViewTapGestureRecognizer.cancelsTouchesInView = NO;
	[self.tableView addGestureRecognizer:_tableViewTapGestureRecognizer];
    [self setEditing:NO animated:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showLeftView:(id)sender
{
    if (self.navigationController.revealController.focusedController == self.navigationController.revealController.leftViewController)
    {
        [self.navigationController.revealController showViewController:self.navigationController.revealController.frontViewController];
    }
    else
    {
        [self.navigationController.revealController showViewController:self.navigationController.revealController.leftViewController];
    }
    NSLog(@"taped leftButtonItem");
}

- (void)setAddToList:(TCList*)list
{
    _addToList = list;
    NSSet *items = _addToList.itemArray;
    selectedItemPropertys = [items valueForKey:@"itemProperty"];
}

#pragma mark - edit
- (void)editItems
{
    [self setEditing:YES animated:YES];
}

- (void)endCellEditing
{
    if(_adding)
        return;
    TCItemPropertyCell *cell = (TCItemPropertyCell *)[self.tableView cellForRowAtIndexPath:selectedIndexPath];
	cell.editingTextField = NO;
	cell.textField.delegate = nil;
	selectedIndexPath = nil;
}

- (void)toggleEditMode:(id)sender
{
    [self setEditing:!self.editing animated:YES];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    _tableViewTapGestureRecognizer.enabled = editing;
    if(_displayMode == TCItemDisplayShowMode)
    {
        if (editing)
        {
            UINavigationItem *n = [self navigationItem];
            UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(toggleEditMode:)];
       
            [n setRightBarButtonItems:@[rightItem] animated:YES];
        
            NSInteger rows= [self.tableView numberOfRowsInSection:0];
            for(int i = 0 ; i < rows ; i ++ )
            {
                TCItemPropertyCell *cell = (TCItemPropertyCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                [cell showCountView:NO];
            }
        }
        else
        {
            UIBarButtonItem *rightItemOne = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditMode:)];
            UIBarButtonItem *rightItemTwo = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStyleBordered target:self action:@selector( addNewItem)];
            [self.navigationItem setRightBarButtonItems:@[rightItemOne,rightItemTwo] animated:YES];
            [self endCellEditing];
            _adding = NO;
        }
    }
    else if(_displayMode == TCItemDisplayAddToListMode)
    {
        UINavigationItem *n = [self navigationItem];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(finishSelect)];
        
        [n setRightBarButtonItems:@[rightItem] animated:YES];
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelSelect)];
        [n setLeftBarButtonItem:leftItem animated:YES];
    }
}

- (NSMutableArray*)newSelectedItemPropertys
{
    if(_newSelectedItemPropertys == nil)
    {
        _newSelectedItemPropertys = [NSMutableArray array];
    }
    return _newSelectedItemPropertys;
}

-(void)cancelSelect
{
    if([self.newSelectedItemPropertys count] != 0)
    {
        UIAlertView *warningView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定取消更改？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [warningView show];

        
#warning 未完成
    }
    else
    {
        [self setEditing:NO animated:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)finishSelect
{
    if([self.newSelectedItemPropertys count] != 0)
    {
        for( int i = 0 ; i < [self.newSelectedItemPropertys count] ; i ++ )
        {
            TCItem *item = [NSEntityDescription insertNewObjectForEntityForName:@"TCItem" inManagedObjectContext:self.managedObjectContext];
            item.itemProperty = [[self.newSelectedItemPropertys objectAtIndex:i] objectForKey:@"itemProperty"];
            item.count = [[[self.newSelectedItemPropertys objectAtIndex:i] objectForKey:@"count"] intValue];
            [_addToList addItemArrayObject:item];
        }
    }
    [self.delegate finishSelectItems:_addToList];
}

- (void)editRow:(UIGestureRecognizer *)editingGestureRecognizer
{
    if(_adding)
        return;
	TCItemPropertyCell *cell = (TCItemPropertyCell *)[self.tableView cellForRowAtIndexPath:selectedIndexPath];
	cell.editingTextField = NO;
	cell.textField.delegate = nil;
	
	cell = (TCItemPropertyCell*)editingGestureRecognizer.view;
	cell.editingTextField = YES;
	cell.textField.delegate = self;
    
	selectedIndexPath = [self.tableView indexPathForCell:cell];
}

-(void)addNewItem
{
#warning 还没有实现
    UIView *coverView = self.coverView;
	coverView.frame = self.view.bounds;
    [self setEditing:NO animated:YES];
    
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:
     ^{[self.tableView scrollToTopAnimated:NO];
         coverView.alpha = 1.0f;
         _adding = YES;
         [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
         coverView.frame = CGRectMake(0.0f,
                                      [TCItemPropertyCell cellHeight],
                                      self.tableView.bounds.size.width,
                                      self.tableView.bounds.size.height - [TCItemPropertyCell cellHeight]);
     }completion:^(BOOL finished){
         TCAddItemPropertyCell * cell = (TCAddItemPropertyCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
         
         UIToolbar *inputToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
         UIBarButtonItem *itemSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
         UIBarButtonItem *finishBBI = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(_addNewItem)];
         [inputToolBar setItems:@[itemSpace,finishBBI] animated:YES];
         [cell.textField setInputAccessoryView:inputToolBar];
         [cell.textField becomeFirstResponder];
     }];
}

-(void)_addNewItem
{
    TCAddItemPropertyCell *cell = (TCAddItemPropertyCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
	UITextField *textField = cell.textField;
	if (textField.text.length == 0)
    {
		[self _cancelAddingList];
		return;
	}
    
	TCItemProperty *itemProperty = [[TCItemProperty alloc] initWithEntity:[NSEntityDescription entityForName:@"TCItemProperty" inManagedObjectContext:self.managedObjectContext] insertIntoManagedObjectContext:self.managedObjectContext];
	itemProperty.name = textField.text;
#warning 添加排序过程和用户
	
    [self _cancelAddingList];
    textField.text = nil;
    NSIndexPath *indexPath = [self.fetchedResultsController indexPathForObject:itemProperty];
#warning 添加分支showMode或AddToListMode
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];

}

- (void)_cancelAddingList
{
	if (!_adding)
    {
		return;
	}
    
	_adding = NO;
    
	TCAddItemPropertyCell *cell = (TCAddItemPropertyCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
	if ([cell.textField isFirstResponder])
    {
		[cell.textField resignFirstResponder];
	}
    
	[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];

	[self setEditing:NO animated:NO];
	[self hideCoverView];
}

#pragma mark - coverView

- (UIView *)coverView
{
	if (!_coverView)
    {
		CGRect frame = self.tableView.bounds;
		frame.origin.y += [TCItemPropertyCell cellHeight];
		frame.size.height -= [TCItemPropertyCell cellHeight];
		_coverView = [[UIView alloc] initWithFrame:frame];
		_coverView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
		_coverView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.9f];
		_coverView.alpha = 0.0f;
        
		
		[_coverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverViewTapped:)]];
		[self.tableView addSubview:_coverView];
	}
	return _coverView;
}

- (void)showCoverView
{
	UIView *coverView = self.coverView;
	[UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction animations:^{
		coverView.alpha = 1.0f;
	} completion:nil];
}


- (BOOL)showingCoverView
{
	return _coverView != nil;
}


- (void)hideCoverView
{
	[UIView animateWithDuration:0.2
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction
                     animations:^{ _coverView.alpha = 0.0f;}
                     completion:^(BOOL finished) {  [_coverView removeFromSuperview];  _coverView = nil;}];
}


- (void)coverViewTapped:(id)sender
{
    //取消添加item
	if (!_adding)
    {
		return;
	}
    
	_adding = NO;
    
	TCAddItemPropertyCell *cell = (TCAddItemPropertyCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
	if ([cell.textField isFirstResponder])
    {
		[cell.textField resignFirstResponder];
	}
    
	[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
	[self setEditing:NO animated:NO];
	[self hideCoverView];
}

#pragma mark - Keyboard

- (void)keyboardDidShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyboardHeight = CGRectGetHeight([aValue CGRectValue]);
    //新tableView.frame为减去keyboard后的大小
    CGFloat height = CGRectGetHeight(self.view.frame) - keyboardHeight;
    
    CGRect cellRect = [self.tableView rectForRowAtIndexPath:selectedIndexPath];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    {
        CGRect rect = self.tableView.frame;
        rect.size.height = height;
        self.tableView.frame = rect;
        //将视图滚动到selected cell位置
        [self.tableView scrollRectToVisible:cellRect animated:YES];
    }
    [UIView commitAnimations];
}


- (void)keyboardWillHide:(NSNotification *)notification
{
	NSDictionary *userInfo = [notification userInfo];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:[[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue]];
    {
        CGRect rect = self.tableView.frame;
        //改回tableview.frame = view.frame
        rect.size.height = CGRectGetHeight(self.view.frame);
        self.tableView.frame = rect;
    }
    [UIView commitAnimations];
}

#pragma mark - TCTableViewController and NSFetchedResultsController
- (NSEntityDescription*)entity
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([TCItemProperty class]) inManagedObjectContext:self.managedObjectContext];
	return entity;
}

- (NSArray *)sortDescriptors
{
    return [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
}

- (NSPredicate *)predicate
{
	return [NSPredicate predicateWithFormat:@"name != nil"];
}

- (NSString *)sectionNameKeyPath
{
	return nil;
}

#pragma mark - TCItemPropertyCellDelegate
- (void)newSelectItemProperty:(TCItemProperty*)itemProperty withCount:(int)count
{
    if([selectedItemPropertys containsObject:itemProperty])
    {
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        fetchRequest.entity = [NSEntityDescription entityForName:@"TCItem" inManagedObjectContext:self.managedObjectContext];
        fetchRequest.sortDescriptors = nil;
        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"itemProperty = %@ AND list = %@ ", itemProperty, _addToList];
        TCItem *item = [[self.managedObjectContext executeFetchRequest:fetchRequest error:nil] objectAtIndex:0];
        item.count = count;
        return;
    }
    NSDictionary *itemDic = [NSDictionary dictionaryWithObjectsAndKeys:itemProperty,@"itemProperty",[NSNumber numberWithInt:count],@"count", nil];
    [self.newSelectedItemPropertys addObject:itemDic];
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(![self isEditing] && !_adding)
    {
        TCItemPropertyCell *selectedCell = (TCItemPropertyCell*)[self.tableView cellForRowAtIndexPath:indexPath];
        [selectedCell showCountView:YES];
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(![self isEditing] && !_adding)
    {
        TCItemPropertyCell *selectedCell = (TCItemPropertyCell*)[self.tableView cellForRowAtIndexPath:indexPath];
        [selectedCell showCountView:NO];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (editingStyle != UITableViewCellEditingStyleDelete)
    {
		return;
	}
	
	TCItemProperty *itemProperty = [self.fetchedResultsController objectAtIndexPath:indexPath];
	[self.managedObjectContext deleteObject:itemProperty];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSInteger rows = [super tableView:tableView numberOfRowsInSection:section];
    
	if (_adding)
    {
		return rows + 1;
	}
	
	return rows;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"itemPropertyCell";
    static NSString *addCellIdentifier = @"addCellIdentifier";
    
	if (_adding && indexPath.row == 0)
    {
		TCAddItemPropertyCell *cell = (TCAddItemPropertyCell *)[tableView dequeueReusableCellWithIdentifier:addCellIdentifier];
		if (!cell)
        {
			cell = [[TCAddItemPropertyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addCellIdentifier];
			cell.textField.delegate = self;
			
		}
        selectedIndexPath = indexPath;
		return cell;
	}
    TCItemPropertyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell)
    {
        cell = [[TCItemPropertyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setEditingAction:@selector(_beginEditingWithGesture:) forTarget:self];
    }
    cell.delegate = self;
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    TCItemProperty *itemProperty = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [(TCItemPropertyCell*)cell setItemProperty:itemProperty];
}
#pragma mark - TextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	textField.background = [[UIImage imageNamed:@"textfield-focused"] stretchableImageWithLeftCapWidth:8 topCapHeight:0];
	
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if (_adding)
    {
        [self _addNewItem];
		return YES;
	}
    
	TCItemProperty *itemProperty = [self.fetchedResultsController objectAtIndexPath:selectedIndexPath];
	itemProperty.name = textField.text;
	
	[self endCellEditing];
	return NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	if (_adding)
    {
//		[self cancelAddingItemPropertys:textField];
	}
}

#pragma mark - Gesture
- (BOOL)_shouldEditRowForGesture:(UIGestureRecognizer *)gestureRecognizer
{
    BOOL didTapGestureSucceed = [gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]];
    return didTapGestureSucceed;
}


- (void)_beginEditingWithGesture:(UIGestureRecognizer *)gestureRecognizer
{
    if ([self _shouldEditRowForGesture:gestureRecognizer])
    {
        if (![self isEditing])
        {
            [self setEditing:YES animated:YES];
        }
        
        [self editRow:gestureRecognizer];
    }
}
@end
