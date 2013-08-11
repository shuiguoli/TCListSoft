//
//  TCEditListViewControler.h
//  TCListSoft
//
//  Created by 徐 哲 on 13-8-1.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCTableViewController.h"
#import "TCItemsViewController.h"
@class TCList;
@interface TCEditListViewControler : TCTableViewController<UIPickerViewDataSource,UIPickerViewDelegate,TCItemsViewControllerAddToListModeDelegate>
{
    UILabel *createdTimeLabel;
    UILabel *notificationDateLabel;
    UIPickerView *categoryPicker;
    UIToolbar *toolBar;
    
}
- (void)selectButton:(id)sender;
@property (nonatomic,strong)TCList *list;
-(void)addNewItem;
- (void)changeNotifDate:(id)sender;
@end
