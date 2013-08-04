//
//  TCListCategoryViewController.m
//  TCListSoft
//
//  Created by 徐 哲 on 13-8-4.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import "TCListCategoryViewController.h"

@interface TCListCategoryViewController ()

@end

@implementation TCListCategoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
#pragma mark - tableViewDelegate
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
