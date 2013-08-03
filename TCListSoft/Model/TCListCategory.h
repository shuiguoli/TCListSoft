//
//  TCListCategory.h
//  TCListSoft
//
//  Created by 徐 哲 on 13-7-30.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TCList;

@interface TCListCategory : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * content;
@property (nonatomic) NSTimeInterval interval;
@property (nonatomic, retain) NSSet *listArray;
@end

@interface TCListCategory (CoreDataGeneratedAccessors)

- (void)addListArrayObject:(TCList *)value;
- (void)removeListArrayObject:(TCList *)value;
- (void)addListArray:(NSSet *)values;
- (void)removeListArray:(NSSet *)values;

@end
