//
//  TCEditListViewControler.m
//  TCListSoft
//
//  Created by 徐 哲 on 13-8-1.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import "TCEditListViewControler.h"
#import "TCItemsViewController.h"
#import "TCList.h"
#import "TCListCategory.h"
#import "TCItem.h"
#import "Tools.h"
#import "TCTableViewController.h"
@interface TCEditListViewControler ()
{
    NSArray *allListCategorys;
}

@end

@implementation TCEditListViewControler

@synthesize list;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        UINavigationItem *n = [self navigationItem];
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc ]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem)];
        UIBarButtonItem *backBar = [[UIBarButtonItem alloc] initWithTitle:[list name] style:UIBarButtonItemStylePlain target:nil action:nil];
        [n setRightBarButtonItem:bbi];
        [n setBackBarButtonItem:backBar];
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        fetchRequest.entity = [NSEntityDescription entityForName:@"TCListCategory" inManagedObjectContext:self.managedObjectContext];
        fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
        allListCategorys = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UILabel *createdLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 89, 21)];
    createdLabel.text = @"添加日期:";
    
    createdTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(117, 20, 175, 21)];
    
    UILabel *notifLabel = [[UILabel alloc ]initWithFrame:CGRectMake(20, 56, 89, 21)];
    notifLabel.text = @"通知日期";
    
    UIButton *changeDateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [changeDateButton setFrame:CGRectMake(117, 56, 175, 21)];
    [changeDateButton addTarget:self action:@selector(changeNotifDate:) forControlEvents:UIControlEventTouchUpInside];
    
    notificationDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(117, 56, 175, 21)];
    
    categoryPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 480, 320, 216)];
    categoryPicker.delegate = self;
    categoryPicker.dataSource = self;
    categoryPicker.showsSelectionIndicator = YES;
    
    [self.tableView setFrame:CGRectMake(0, 91, 320, 416)];
    toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 480, 320, 44)];
    [self.view addSubview:createdLabel];
    [self.view addSubview:createdTimeLabel];
    [self.view addSubview:notifLabel];
    [self.view addSubview:notificationDateLabel];
    [self.view addSubview:changeDateButton];
    //[self.view addSubview:toolBar];
    
    UIBarButtonItem *finishBar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(selectButton:)];
    UIBarButtonItem *itemSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:@[itemSpace,finishBar] animated:YES];
    [self.view addSubview:categoryPicker];
    [self.view addSubview:toolBar];
    // Do any additional setup after loading the view from its nib.
    createdTimeLabel.text = [Tools stringFromDate:[list valueForKey:@"createdDate"]];
    UIBarButtonItem *backBarItem = [[UIBarButtonItem alloc] initWithTitle:list.name style:UIBarButtonItemStyleBordered target:self action:nil];
    [self.navigationItem setBackBarButtonItem:backBarItem];
    
}

-(void) viewWillAppear:(BOOL)animated
{

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

-(void)finishSelectItems:(TCList*)addToList
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.managedObjectContext save:nil];
}

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

#pragma mark - tableViewDataSource
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    fetchRequest.entity = [NSEntityDescription entityForName:@"TCItem" inManagedObjectContext:self.managedObjectContext];
//    fetchRequest.sortDescriptors = nil;
//    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"list = %@",list];
//    TCItem *item = [[self.managedObjectContext executeFetchRequest:fetchRequest error:nil] objectAtIndex:0];
////    item.count = count;
//    return 1;
//}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    TCItem *item = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [cell.textLabel setText:[item valueForKeyPath:@"itemProperty.name"]];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"itemCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
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


- (IBAction)changeNotifDate:(id)sender
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
    notificationDateLabel.text = [Tools stringFromDate:notifDate];
    NSLog(@"HAHA");
}


@end
