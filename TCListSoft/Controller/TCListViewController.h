//
//  TCListViewController.h
//  TCListSoft
//
//  Created by 徐 哲 on 13-7-31.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UITableView *tableView;
}

- (IBAction)saveChange:(id)sender;
- (void)addNewList;
@end
