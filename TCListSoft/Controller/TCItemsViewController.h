//
//  TCItemsViewController.h
//  TCListSoft
//
//  Created by 徐 哲 on 13-8-1.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCItemPropertyCell.h"
#import "TCTableViewController.h"
@class TCList;
//ItemsView显示模式
typedef enum{
    TCItemDisplayAddToListMode,
    TCItemDisplayShowMode
}TCItemsDisplayMode;

@protocol TCItemsViewControllerAddToListModeDelegate <NSObject>

-(void)finishSelectItems:(TCList*)addToList;

@end

@interface TCItemsViewController : TCTableViewController<TCItemPropertyCellDelegate>
{

}
@property (nonatomic,readonly) TCItemsDisplayMode displayMode;
@property (nonatomic,strong) UIView *coverView;
@property (nonatomic,weak) TCList *addToList;
@property (nonatomic,weak) UIViewController<TCItemsViewControllerAddToListModeDelegate> *delegate;
- (id)initWithSytle:(UITableViewStyle)style andDisplayMode:(TCItemsDisplayMode)mode;
- (void)showLeftView:(id)sender;
- (void)cancelSelect;
- (void)finishSelect;
- (void)addNewItem;

@end



