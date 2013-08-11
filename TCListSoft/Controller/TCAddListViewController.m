//
//  TCAddListViewController.m
//  TCListSoft
//
//  Created by 徐 哲 on 13-8-5.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import "TCAddListViewController.h"
#import "TCAddListCell.h"
#import "TCList.h"
#import "TCListViewController.h"
#import "TCListCategory.h"
#import "TCTableViewController.h"
#import "Tools.h"
@interface TCAddListViewController ()
{
    NSArray *allListCategorys;
    NSString *notificationDate;
}
@end

@implementation TCAddListViewController
@synthesize list;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"newList";
        UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(finishAddList:)];
        UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelAddList:)];
        self.navigationItem.leftBarButtonItem = leftBarButtonItem;
        self.navigationItem.rightBarButtonItem = rightBarButtonItem;
       
    }
    return self;
}


-(void)finishAddlist:(id)sender

{
   //以后改完成数据存储
    
}

-(void)cancelAddList:(id)sender
{
   
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UINib *nameNib = [UINib nibWithNibName:@"TCAddListCell" bundle:nil];
    [addListTableView registerNib:nameNib forCellReuseIdentifier:@"TCAddListCell"];
    
    //
    categoryPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 480, 320, 216)];
    categoryPicker.delegate = self;
    categoryPicker.dataSource = self;
    categoryPicker.showsSelectionIndicator = YES;
    
    [self.view addSubview:categoryPicker];
    

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
}
#pragma mark - TableViewDelegate
-(void)setNotifDate
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // deselect the current row (don't keep the table selection persistent)
	[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
    static NSString *addListNameCellIdentifier = @"TCAddListCell";
    TCAddListCell *addListCell = [tableView dequeueReusableCellWithIdentifier:addListNameCellIdentifier];
    addListCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
        
    if (indexPath.section == 0)
    {
        if (indexPath.row == 1)
        {
            //[self selectButton];
            [self setNotifDate];
            addListCell.cellTextField.placeholder = notificationDate;
        }
    }
    NSLog(@"tapped");
}
- (void)viewDidUnload {
    addListTableView = nil;
    [super viewDidUnload];
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

-(void)animationFinished
{
    NSLog(@"动画结束!");
}

- (void)selectButton
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
@end
