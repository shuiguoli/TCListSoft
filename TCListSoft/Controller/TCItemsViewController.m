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
@interface TCItemsViewController ()
{
    NSArray *allItems;
    TCDataStore *dataStore;
}
@end

@implementation TCItemsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        dataStore = [TCDataStore sharedStore];
        allItems = [dataStore allItems];
        [self.navigationItem setTitle:@"清单库"];
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
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [allItems count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"itemCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    TCItem *item = [allItems objectAtIndex:indexPath.row];
    cell.textLabel.text = [item valueForKeyPath:@"itemProperty.name"];
    return cell;
}
@end
