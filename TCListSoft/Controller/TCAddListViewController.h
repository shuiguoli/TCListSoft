//
//  TCAddListViewController.h
//  TCListSoft
//
//  Created by 徐 哲 on 13-8-5.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCItemsViewController.h"
#import "TCTableViewController.h"
@class TCList;
typedef enum{
    TCAddListViewMode,
    TCEditListViewMode
}TCListViewMode;

@interface TCAddListViewController : TCTableViewController<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,TCItemsViewControllerAddToListModeDelegate>
{
    
    __weak IBOutlet UITableView *addListTableView;
    
    UIPickerView *categoryPicker;
    UIToolbar *toolBar;
}
@property (nonatomic,readonly) TCListViewMode displayMode;
@property (nonatomic,strong)TCList *list;

@property (nonatomic, retain) UIDatePicker *datePickerView;///

- (void)addNewItem;
- (void)changeNotifDate:(id)sender;
- (void)selectButton:(id)sender;
- (id)initWithSytle:(UITableViewStyle)style andDisplayMode:(TCListViewMode)mode;
- (void)finishSelectItems:(TCList*)list;
@end
