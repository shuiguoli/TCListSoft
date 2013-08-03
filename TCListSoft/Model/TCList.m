//
//  TCList.m
//  TCListSoft
//
//  Created by 徐 哲 on 13-7-30.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import "TCList.h"
#import "TCItem.h"


@implementation TCList

@dynamic name;
@dynamic percent;
@dynamic createdDate;
@dynamic notificationDate;
@dynamic listCategory;
@dynamic itemArray;

-(void) awakeFromFetch
{
    [super awakeFromFetch];
    
    
}

-(void) awakeFromInsert
{
    [super awakeFromInsert];
    
    [self setPercent:0.0];
    NSTimeInterval t = [[NSDate date] timeIntervalSinceReferenceDate];
    [self setCreatedDate:t];
}

@end
