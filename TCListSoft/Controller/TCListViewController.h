//
//  TCListViewController.h
//  TCListSoft
//
//  Created by 徐 哲 on 13-7-31.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCTableViewController.h"
@interface TCListViewController : TCTableViewController
{
    
}

- (void)saveChange:(id)sender;
- (void)addNewList;
- (void)showLeftView:(id)sender;
@end
