//
//  TCItem.m
//  TCListSoft
//
//  Created by 徐 哲 on 13-7-30.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import "TCItem.h"


@implementation TCItem

@dynamic count;
@dynamic didDone;
@dynamic itemProperty;
@dynamic orderingValue;
@dynamic addToListDate;

-(void) awakeFromInsert
{
    [super awakeFromInsert];
    
}
@end
