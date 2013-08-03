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
@interface TCEditListViewControler ()
{
    
}


@end

@implementation TCEditListViewControler

@synthesize list;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UINavigationItem *n = [self navigationItem];
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc ]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem)];
        
        [n setRightBarButtonItem:bbi];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    categoryPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 480, 320, 216)];
    categoryPicker.delegate = self;
    categoryPicker.dataSource = self;
    toolBar.frame = CGRectMake(0, 480, 320, 44);
    [self.view addSubview:categoryPicker];
    [self.view addSubview:toolBar];
    // Do any additional setup after loading the view from its nib.
    createdTimeLabel.text = [Tools stringFromDate:[list valueForKey:@"createdDate"]];
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
#pragma mark - tableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSSet *itemArray = [list valueForKey:@"itemArray"];
    return [itemArray count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"itemCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    TCItem *item = [[list valueForKey:@"itemArray"] anyObject];
    cell.textLabel.text = [item valueForKeyPath:@"itemProperty.name"];
    return cell;
}
#pragma mark - pickerViewDelegate
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 4;
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return @"test";
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(void) addNewItem
{
    TCItemsViewController *newIsVC = [[TCItemsViewController alloc] initWithNibName:nil bundle:nil];
    [[self navigationController] pushViewController:newIsVC animated:YES];
}


- (IBAction)changeNotifDate:(id)sender
{
    //动画弹出显示catagoryPicker
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.6];//动画时间长度，单位秒，浮点数
    [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    toolBar.frame = CGRectMake(0, 156, 320, 44);
    categoryPicker.frame = CGRectMake(0, 200, 320, 260);
    
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用animationFinished
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
//    [categoryPicker setHidden:NO];
}
-(void)animationFinished
{
    NSLog(@"动画结束!");
}
- (IBAction)selectButton:(id)sender
{
    NSLog(@"HAHA");
}
@end
