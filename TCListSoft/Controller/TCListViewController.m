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
#import "TCEditListViewController.h"
@interface TCListViewController ()
{
    NSArray *allLists;
    TCDataStore *dataStore;
}
@end

@implementation TCListViewController

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
        dataStore = [TCDataStore sharedStore];
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
        {
            // 这里判断是否第一次
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"第一次" message:@"进入App" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
            [dataStore test];
            [alert show];
        }
        UINavigationItem *n = [self navigationItem];
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc ]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewList)];
        n.title = @"List";
        [n setRightBarButtonItem:bbi];

        allLists = [dataStore allList];
        return self;
    }
    return nil;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [allLists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    TCList *list = [allLists objectAtIndex:indexPath.row];
    cell.textLabel.text = [list valueForKey:@"name"];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    // Navigation logic may go here. Create and push another view controller.
    
     TCEditListViewController *detailViewController = [[TCEditListViewController alloc] initWithNibName:nil bundle:nil];
    [detailViewController setList:[allLists objectAtIndex:indexPath.row]];
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
    
}

- (IBAction)saveChange:(id)sender
{
    [dataStore saveChanges];
    UIView *view = [[UIView alloc] initWithFrame:tableView.frame];
    view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    tableView.backgroundView = view;
    debugMethod();
}

- (void)addNewList
{
    
}
@end
