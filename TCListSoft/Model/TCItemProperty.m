//
//  TCItemProperty.m
//  TCListSoft
//
//  Created by 徐 哲 on 13-7-30.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import "TCItemProperty.h"
#import "TCItemCategory.h"


@implementation TCItemProperty

@dynamic name;
@dynamic thumbnailData;
@dynamic thumbnail;
@dynamic createdDate;
@dynamic content;
@dynamic category;

-(void) awakeFromFetch
{
    [super awakeFromFetch];
    
    UIImage *tn = [UIImage imageWithData:[self thumbnailData]];
    [self setThumbnail:tn];
}

-(void) awakeFromInsert
{
    [super awakeFromInsert];
    
    NSTimeInterval t = [[NSDate date] timeIntervalSinceReferenceDate];
    [self setCreatedDate:t];
}
@end
