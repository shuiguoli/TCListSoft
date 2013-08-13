//
//  TCAddListViewController.m
//  TCListSoft
//
//  Created by 徐 哲 on 13-8-5.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import "TCAddListViewController.h"
#import "TCAddListCell.h"
#import "TCListCategory.h"
#import "TCList.h"
#import "Tools.h"
#import "TCItem.h"
@interface TCAddListViewController ()
{
    NSArray *allListCategorys;
    NSString *notificationDate;
}
@end

@implementation TCAddListViewController

#warning datePicker
@synthesize datePickerView;////

@synthesize displayMode = _displayMode;
@synthesize list;

-(id)initWithSytle:(UITableViewStyle)style andDisplayMode:(TCListViewMode)mode
{
    self = [super initWithStyle:style];
    if (self)
    {
        _displayMode = mode;
        UINavigationItem *n = [self navigationItem];
        
        if (mode == TCAddListViewMode)
        {
            self.title = @"newList";
            UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(finishAddList:)];
            UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelAddList:)];
            [n setLeftBarButtonItem:leftBarButtonItem];
            [n setRightBarButtonItem:rightBarButtonItem];
            
        }
        if (mode == TCEditListViewMode)
        {
            UIBarButtonItem *bbi = [[UIBarButtonItem alloc ]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem)];
            UIBarButtonItem *backBar = [[UIBarButtonItem alloc] initWithTitle:[list name] style:UIBarButtonItemStylePlain target:nil action:nil];
            [n setRightBarButtonItem:bbi];
            [n setBackBarButtonItem:backBar];
        }
        //不明白
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        fetchRequest.entity = [NSEntityDescription entityForName:@"TCListCategory" inManagedObjectContext:self.managedObjectContext];
        fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
        allListCategorys = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    }
    return self;
}

-(void)finishAddList:(id)sender
{
    
}
-(void)cancelAddList:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
    [self.managedObjectContext save:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UINib *nameNib = [UINib nibWithNibName:@"TCAddListCell" bundle:nil];
    [addListTableView registerNib:nameNib forCellReuseIdentifier:@"TCAddListCell"];
    
    categoryPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 480, 320, 216)];
    categoryPicker.delegate = self;
    categoryPicker.dataSource = self;
    categoryPicker.showsSelectionIndicator = YES;
    
    toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 480, 320, 44)];
    UIBarButtonItem *finishBar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(selectButton:)];
    UIBarButtonItem *itemSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:@[itemSpace,finishBar] animated:YES];
    
    [self.view addSubview:categoryPicker];
    [self.view addSubview:toolBar];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setList:(TCList *)oneList
{
    list = oneList;
    UINavigationItem *n = [self navigationItem];
    [n setTitle:oneList.name];
}

#pragma mark - tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 2;
    else if(section == 1)
        return 1;
    else if(section ==2)
        return 1;
    return 0;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    TCItem *item = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [cell.textLabel setText:[item valueForKeyPath:@"itemProperty.name"]];
}

//如何改
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *addListNameCellIdentifier = @"TCAddListCell";
    TCAddListCell *addListCell = [tableView dequeueReusableCellWithIdentifier:addListNameCellIdentifier];
    addListCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if(indexPath.section == 0)
    {
        if(indexPath.row == 0)
        {
            addListCell.cellTextField.placeholder = @"名字";
            
            addListCell.accessoryType = UITableViewCellAccessoryNone;
        }
        if(indexPath.row == 1)
        {
            NSString *notifDate = @"点击选择提醒时间";
            addListCell.cellTextField.placeholder = notifDate;
        }
    }
    if(indexPath.section == 1)
    {
        if(indexPath.row == 0)
        {
            addListCell.cellTextField.placeholder = @"更改类别";
        }
    }
    if(indexPath.section == 2)
    {
        if(indexPath.row == 0)
        {
            addListCell.cellTextField.placeholder = @"更改类别";
        }
    }
    
    
    return addListCell;
}

-(void)finishSelectItems:(TCList*)list
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.managedObjectContext save:nil];
}

#pragma mark - TableViewDelegate
//不知怎么写啦
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *viewController = nil;
    if (_displayMode == TCAddListViewMode)
    {
        
    
        if (indexPath.section == 0)
        {
            if (indexPath.row == 1)
           {
            [self changeNotifDate];
            
           }
        }
    }
    
    NSLog(@"tapped");
}
- (void)viewDidUnload {
    addListTableView = nil;
    [super viewDidUnload];
}

#pragma mark - TCTableViewController and NSFetchedResultsController

- (NSEntityDescription*)entity
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([TCItem class]) inManagedObjectContext:self.managedObjectContext];
	return entity;
}

- (NSArray *)sortDescriptors
{
    return [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"orderingValue" ascending:YES]];
}

- (NSPredicate *)predicate
{
	return [NSPredicate predicateWithFormat:@"list == %@",list];
}

- (NSString *)sectionNameKeyPath
{
	return nil;
}

#pragma mark - pickerViewDelegate

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [allListCategorys count];
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    TCListCategory *listCategory = [allListCategorys objectAtIndex:row];
    NSString *str = [listCategory valueForKey:@"name"];
    
    return str;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (void)changeNotifDate
{
    //动画弹出显示catagoryPicker
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];//动画时间长度，单位秒，浮点数  //后期修改
    [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    toolBar.frame = CGRectMake(0, 156, 320, 44);
    categoryPicker.frame = CGRectMake(0, 200, 320, 216);
    
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用animationFinished
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
}
-(void)animationFinished
{
    NSLog(@"动画结束!");
}

- (void)selectButton:(id)sender
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];//动画时间长度，单位秒，浮点数  //后期修改
    toolBar.frame = CGRectMake(0, 480, 320, 44);
    categoryPicker.frame = CGRectMake(0, 480, 320, 216);
    
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用animationFinished
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
    NSInteger index = [categoryPicker selectedRowInComponent:0];
    NSTimeInterval intervalDate = [[[allListCategorys objectAtIndex:index] valueForKey:@"interval"] doubleValue];
    NSDate *time = [list valueForKey:@"createdDate"];
    //    NSDate *listCreatedDate = [NSDate dateWithTimeIntervalSince1970:time];
    NSDate *notifDate = [NSDate dateWithTimeInterval:intervalDate sinceDate:time];
    notificationDate = [Tools stringFromDate:notifDate];
    NSLog(@"HAHA");
}

-(void) addNewItem
{
    TCItemsViewController *newItemsVC = [[TCItemsViewController alloc] initWithSytle:UITableViewStyleGrouped andDisplayMode:TCItemDisplayAddToListMode];
    newItemsVC.addToList = self.list;
    newItemsVC.delegate = self;
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:newItemsVC];
    //设置弹出视图形式
    newItemsVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self.navigationController presentViewController:navigation animated:YES completion:nil];
}

#warning datePicke
#pragma mark UIPickerView - Date/Time
//生成时间还没用
- (void)createDatePicker
{
	datePickerView = [[UIDatePicker alloc] initWithFrame:CGRectZero];
	datePickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
	datePickerView.datePickerMode = UIDatePickerModeDateAndTime;
	
	// note we are using CGRectZero for the dimensions of our picker view,
	// this is because picker views have a built in optimum size,
	// you just need to set the correct origin in your view.
	//
	// position the picker at the bottom
	CGSize pickerSize = [categoryPicker sizeThatFits:CGSizeZero];
	datePickerView.frame = CGRectMake(0, 480, 320, 216);
	
	// add this picker to our view controller, initially hidden
	datePickerView.hidden = YES;
	[self.view addSubview:datePickerView];
}

@end
