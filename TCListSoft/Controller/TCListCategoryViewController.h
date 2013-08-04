//
//  TCListCategoryViewController.h
//  TCListSoft
//
//  Created by 徐 哲 on 13-8-4.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCListCategoryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    
    __weak IBOutlet UITableView *_tableView;
    __weak IBOutlet UIToolbar *tooBar;
}

- (IBAction)showSettings:(id)sender;
- (IBAction)setEditing:(id)sender;
@end
