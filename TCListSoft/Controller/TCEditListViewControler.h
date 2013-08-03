//
//  TCEditListViewControler.h
//  TCListSoft
//
//  Created by 徐 哲 on 13-8-1.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TCList;
@interface TCEditListViewControler : UIViewController<UITableViewDelegate,UITableViewDataSource,UIPickerViewDataSource,UIPickerViewDelegate>
{
    __weak IBOutlet UILabel *createdTimeLabel;
    __weak IBOutlet UILabel *notificationDateLabel;
    __weak IBOutlet UITableView *tableView;
    __weak IBOutlet UIPickerView *categoryPicker;
    
}
@property (nonatomic,strong)TCList *list;
-(void)addNewItem;
- (IBAction)changeNotifDate:(id)sender;
@end
