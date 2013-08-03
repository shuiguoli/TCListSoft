//
//  TCDataStore.h
//  TCListSoft
//
//  Created by 徐 哲 on 13-7-30.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TCItem;
@class TCList;
@class TCItemCategory;
@class TCItemProperty;
@class TCListCategory;

@interface TCDataStore : NSObject
{
    NSMutableArray *allItems;
    NSMutableArray *allLists;
    NSMutableArray *allItemPropertys;
    NSMutableArray *allItemCategorys;
    NSMutableArray *allListCategorys;
    NSManagedObjectContext *context;
    NSManagedObjectModel *model;
}

+ (TCDataStore *)sharedStore;
- (void)test;
//item
- (void)removeItem:(TCItem*)p;

- (NSArray *)allItems;

- (TCItem *)createItem;

- (void)loadAllItems;

- (void)moveItemAtIndex:(int)from toIndex:(int)to;

//itemProperty
- (void)removeItemProperty:(TCItemProperty*)p;

- (NSArray *)allItemPropertys;

- (TCItemProperty *)createItemProperty;

- (void)loadAllItemPropertys;

//itemCategory

- (void)removeItemCategory:(TCItemCategory*)itemCategpry;

- (NSArray*)allItemCategorys;

- (TCItemCategory*)createItemCategory;

- (void)loadAllItemCategorys;

//list
- (void)removeList:(TCList*)p;

- (NSArray *)allList;

- (TCList *)createList;

- (void)loadAllLists;

//listCategory

- (void)removeListCategory:(TCListCategory*)listCategory;

- (NSArray*)allListCategorys;

- (TCListCategory*)createListCategory;

- (void)loadAllListCategorys;

- (BOOL)saveChanges;

@end
