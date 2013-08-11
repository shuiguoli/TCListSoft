//
//  TCItemPropertyCell.h
//  TCListSoft
//
//  Created by 徐 哲 on 13-8-6.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCCell.h"
@class TCItemProperty;
@class TCItem;

@protocol TCItemPropertyCellDelegate <NSObject>

-(void)newSelectItemProperty:(TCItemProperty*)itemProperty withCount:(int)count;
@end


@interface TCItemPropertyCell : TCCell
@property (nonatomic,strong)TCItemProperty *itemProperty;
@property (nonatomic,strong,readonly)TCItem *createdItem;
#warning 后期需要修改
@property (nonatomic,strong,readonly)UISlider *countView;
@property (nonatomic)BOOL isInList;
@property (nonatomic,weak)id<TCItemPropertyCellDelegate> delegate;

- (void)showCountView:(BOOL)show;

@end
