//
//  TCAddListViewController.h
//  TCListSoft
//
//  Created by 徐 哲 on 13-8-5.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCTableViewController.h"
@class TCList;
@interface TCAddListViewController : TCTableViewController<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    
     UITableView *addListTableView;
    
    UIPickerView *categoryPicker;
    UIToolbar *toolBar;
}

@property (nonatomic,strong)TCList *list;

-(void)finishSelectItems:(TCList*)list;
@end
