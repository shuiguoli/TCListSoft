//
//  TCItemsViewController.h
//  TCListSoft
//
//  Created by 徐 哲 on 13-8-1.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCItemsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UITableView *tableView;
}

@end
