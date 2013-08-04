//
//  TCListCategoryViewController.m
//  TCListSoft
//
//  Created by 徐 哲 on 13-8-4.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import "TCListCategoryViewController.h"
#import "TCListCategory.h"
#import "TCDataStore.h"

@interface TCListCategoryViewController ()
{
    NSArray *allListCategorys;
}
@end

@implementation TCListCategoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        allListCategorys = [[TCDataStore sharedStore] allListCategorys];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    _tableView = nil;
    tooBar = nil;
    [super viewDidUnload];
}

- (IBAction)showSettings:(id)sender
{
    
}

- (IBAction)setEditing:(id)sender
{
    if([self isEditing])
    {
        [sender setTitle:@"编辑" forState:UIControlStateNormal];
        [self setEditing:NO animated:YES];
    }
    else
    {
        [sender setTitle:@"完成" forState:UIControlStateNormal];
        [self setEditing:YES animated:YES];
    }
}
#pragma mark - tableViewDelegate
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [allListCategorys count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellListCategory";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    TCListCategory *listCategory = [allListCategorys objectAtIndex:indexPath.row];
    NSString *name = [listCategory valueForKey:@"name"];
    cell.textLabel.text = name;
    
    return cell;
}
@end
