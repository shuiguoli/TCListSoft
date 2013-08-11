//
//  TCSettingsViewController.m
//  TCListSoft
//
//  Created by 徐 哲 on 13-8-4.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import "TCSettingsViewController.h"

@interface TCSettingsViewController ()

@end

@implementation TCSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UINavigationItem *n = [self navigationItem];
//        UIBarButtonItem *bbi = [[UIBarButtonItem alloc ]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewList)];
        n.title = @"设置";
//        [n setRightBarButtonItem:bbi];

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

- (void)viewDidUnload {
    _tableView = nil;
    [super viewDidUnload];
}
@end
