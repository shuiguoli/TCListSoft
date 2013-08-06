//
//  TCEditListViewController.h
//  TCListSoft
//
//  Created by 谷 on 13-8-6.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TCList;
@interface TCEditListViewController : UIViewController<UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    __weak IBOutlet UILabel *createdListTimeLabel;
    __weak IBOutlet UILabel *notificationListDateLabel;
    
   
    
    
}
@property (nonatomic, retain) UITextView *textView;

@property (nonatomic,strong)  TCList *list;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;


- (IBAction)addSubList:(id)sender;
- (IBAction)changeNotifDate:(id)sender;


@end


