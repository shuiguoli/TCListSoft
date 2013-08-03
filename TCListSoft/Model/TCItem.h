//
//  TCItem.h
//  TCListSoft
//
//  Created by 徐 哲 on 13-7-30.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TCItem : NSManagedObject

@property (nonatomic) int32_t count;
@property (nonatomic) BOOL didDone;
@property (nonatomic, retain) NSManagedObject *itemProperty;
@property (nonatomic) int32_t orderingValue;
@property (nonatomic) NSTimeInterval addToListDate;
@end
