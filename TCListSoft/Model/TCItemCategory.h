//
//  TCItemCategory.h
//  TCListSoft
//
//  Created by 徐 哲 on 13-7-30.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TCItemCategory : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * content;
@property (nonatomic) NSTimeInterval interval;
@property (nonatomic, retain) NSSet *itemArray;
@end

@interface TCItemCategory (CoreDataGeneratedAccessors)

- (void)addItemArrayObject:(NSManagedObject *)value;
- (void)removeItemArrayObject:(NSManagedObject *)value;
- (void)addItemArray:(NSSet *)values;
- (void)removeItemArray:(NSSet *)values;

@end
