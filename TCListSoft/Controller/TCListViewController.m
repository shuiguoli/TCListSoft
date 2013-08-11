//
//  TCListViewController.m
//  TCListSoft
//
//  Created by 徐 哲 on 13-7-31.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import "TCListViewController.h"
#import "TCDataStore.h"
#import "TCList.h"
#import "TCListCategory.h"
#import "TCDataStore.h"
#import "TCEditListViewControler.h"
#import "TCAddListViewController.h"
#import "TCTableViewController.h"
@interface TCListViewController ()
{

}
@end

@implementation TCListViewController

-(id) initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if(self)
    {
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
        {
            // 这里判断是否第一次
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"第一次" message:@"进入App" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
            [alert show];
        }
        UIImage *revealImagePortrait = [UIImage imageNamed:@"reveal_menu_icon_portrait"];
        UIImage *revealImageLandscape = [UIImage imageNamed:@"reveal_menu_icon_landscape"];
        UINavigationItem *n = [self navigationItem];
        n.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:revealImagePortrait landscapeImagePhone:revealImageLandscape style:UIBarButtonItemStylePlain target:self action:@selector(showLeftView:)];
		n.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStyleBordered target:self action:@selector(addList:)];
        n.title = @"List";
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *headerView = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 300, 44)];
    headerView.backgroundColor = [UIColor grayColor];
    [headerView addTarget:self action:@selector(addList:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView setTableHeaderView:headerView];
    [self setEditing:NO animated:YES];
    // Uncomment the following line to preserve selection between presentations.
//    self.clearsSelectionOnViewWillAppear = NO;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - editing
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	[super setEditing:editing animated:animated];
	if (editing) {
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(toggleEditMode:)];
	}
    else
    {
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleBordered target:self action:@selector(toggleEditMode:)];
	}
}

- (void)toggleEditMode:(id)sender
{
	[self setEditing:!self.editing animated:YES];
}

- (void)addList:(id)sender
{
    TCAddListViewController *addListViewController = [[TCAddListViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:addListViewController];
    //设置弹出视图形式
    addListViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.navigationController presentViewController:navigation animated:YES completion:nil];
}

- (void)_addList:(TCList*)newList
{
    //完成后回调
}

- (NSEntityDescription*)entity
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([TCList class]) inManagedObjectContext:self.managedObjectContext];
	return entity;
}

- (NSArray *)sortDescriptors
{
    return [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
}

- (NSPredicate *)predicate
{
	return nil;
}

- (NSString *)sectionNameKeyPath
{
	return nil;
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    TCList *list = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [cell.textLabel setText:list.name];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    // Navigation logic may go here. Create and push another view controller.
    
     TCEditListViewControler *detailViewController = [[TCEditListViewControler alloc] initWithStyle:UITableViewStyleGrouped];
    [detailViewController setList:[self.fetchedResultsController objectAtIndexPath:indexPath]];
    [self.navigationController pushViewController:detailViewController animated:YES];
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
@end
