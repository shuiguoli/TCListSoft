//
//  TCList.h
//  TCListSoft
//
//  Created by 徐 哲 on 13-7-30.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TCItem;

@interface TCList : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic) double percent;
@property (nonatomic) NSTimeInterval createdDate;
@property (nonatomic) NSTimeInterval notificationDate;
@property (nonatomic, retain) NSManagedObject *listCategory;
@property (nonatomic, retain) NSSet *itemArray;
@end

@interface TCList (CoreDataGeneratedAccessors)

- (void)addItemArrayObject:(TCItem *)value;
- (void)removeItemArrayObject:(TCItem *)value;
- (void)addItemArray:(NSSet *)values;
- (void)removeItemArray:(NSSet *)values;

@end
