//
//  TCDataStore.m
//  TCListSoft
//
//  Created by 徐 哲 on 13-7-30.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import "TCDataStore.h"
#import "TCItem.h"
#import "TCItemCategory.h"
#import "TCItemProperty.h"
#import "TCList.h"
#import "TCListCategory.h"
#import "TCAppDelegate.h"
@implementation TCDataStore

@synthesize context = _context;

+ (TCDataStore *)sharedStore
{
    static TCDataStore * sharedStore = nil;
    if(sharedStore == nil)
    {
        sharedStore = [[super allocWithZone:nil] init];
    }
    return sharedStore;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}

- (id)init
{
    self = [super init];
    if(self)
    {
        //从xcdatamodeld文件读取信息
        self.context = [(TCAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
        
        [self loadAllItemCategorys];
        [self loadAllItemPropertys];
        [self loadAllItems];
        [self loadAllListCategorys];
        [self loadAllLists];
        
    }
    return self;
}

- (NSManagedObjectContext*)moContext
{
    return _context;
}
#pragma mark - Item
-(NSArray *)allItems
{
    return allItems;
}

- (void)loadAllItems
{
    if (!allItems)
    {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *e = [NSEntityDescription entityForName:@"TCItem" inManagedObjectContext:_context];
        [request setEntity:e];
        
        NSSortDescriptor *sd = [NSSortDescriptor
                                sortDescriptorWithKey:@"orderingValue"
                                ascending:YES];
        [request setSortDescriptors:[NSArray arrayWithObject:sd]];
        
        NSError *error;
        NSArray *result = [self.context executeFetchRequest:request error:&error];
        if (!result)
        {
            debugMethod();
            [NSException raise:@"Fetch failed"
                        format:@"Reason: %@", [error localizedDescription]];
        }
        
        allItems = [[NSMutableArray alloc] initWithArray:result];
    }
}

- (TCItem *)createItem
{
    int32_t order;
    if ([allItems count] == 0)
    {
        order = 1;
    }
    else
    {
        order = [[allItems lastObject] orderingValue] + 1;
    }
    //    NSLog(@"Adding after %d items, order = %d", [allItems count], order);
    
    TCItem *p = [NSEntityDescription insertNewObjectForEntityForName:@"TCItem"
                                              inManagedObjectContext:self.context];
    
    [p setOrderingValue:order];
    
    [allItems addObject:p];
    
    return p;
}

- (void)removeItem:(TCItem *)p
{
    //    NSString *key = [p
    [self.context deleteObject:p];
    [allItems removeObjectIdenticalTo:p];
}

- (void)moveItemAtIndex:(int)from
                toIndex:(int)to
{
    if (from == to)
    {
        return;
    }
    //获得要移动的item，先删除，再插入
    TCItem *p = [allItems objectAtIndex:from];
    
    [allItems removeObjectAtIndex:from];
    
    //在to位置插入
    [allItems insertObject:p atIndex:to];
    
    // 计算新的orderValue for the object that was moved
    double lowerBound = 0.0;
    
    // Is there an object before it in the array?
    if (to > 0)
    {
        lowerBound = [[allItems objectAtIndex:to - 1] orderingValue];
    }
    else
    {
        lowerBound = [[allItems objectAtIndex:1] orderingValue] - 2.0;
    }
    
    double upperBound = 0.0;
    
    // Is there an object after it in the array?
    if (to < [allItems count] - 1)
    {
        upperBound = [[allItems objectAtIndex:to + 1] orderingValue];
    }
    else
    {
        upperBound = [[allItems objectAtIndex:to - 1] orderingValue] + 2.0;
    }
    
    double newOrderValue = (lowerBound + upperBound) / 2.0;
    
    NSLog(@"moving to order %f", newOrderValue);
    [p setOrderingValue:newOrderValue];
}

#pragma mark - ItemProperty
- (NSArray *)allItemPropertys
{
    return allItemPropertys;
}

- (void)loadAllItemPropertys
{
    if (!allItemPropertys)
    {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *e = [NSEntityDescription entityForName:@"TCItemProperty" inManagedObjectContext:_context];
        [request setEntity:e];
        
        //需要排序时添加
        //        NSSortDescriptor *sd = [NSSortDescriptor
        //                                sortDescriptorWithKey:@"orderingValue"
        //                                ascending:YES];
        //        [request setSortDescriptors:[NSArray arrayWithObject:sd]];
        
        NSError *error;
        NSArray *result = [self.context executeFetchRequest:request error:&error];
        if (!result)
        {
            debugMethod();
            [NSException raise:@"Fetch failed"
                        format:@"Reason: %@", [error localizedDescription]];
        }
        
        allItemPropertys = [[NSMutableArray alloc] initWithArray:result];
    }
    
}

- (TCItemProperty *)createItemProperty
{
    TCItemProperty *ip = [NSEntityDescription insertNewObjectForEntityForName:@"TCItemProperty" inManagedObjectContext:self.context];
    
    [allItemPropertys addObject:ip];
    return ip;
}

- (void)removeItemProperty:(TCItemProperty*)p
{
    [self.context deleteObject:p];
    [allItemPropertys removeObject:p];
}

#pragma mark - ItemCategory

- (NSArray*)allItemCategorys
{
    return allItemCategorys;
}

- (void)loadAllItemCategorys
{
    if (!allItemCategorys)
    {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *e = [NSEntityDescription entityForName:@"TCItemCategory" inManagedObjectContext:_context];
        [request setEntity:e];
        
        //        NSSortDescriptor *sd = [NSSortDescriptor
        //                                sortDescriptorWithKey:@"orderingValue"
        //                                ascending:YES];
        //        [request setSortDescriptors:[NSArray arrayWithObject:sd]];
        
        NSError *error;
        NSArray *result = [self.context executeFetchRequest:request error:&error];
        if (!result)
        {
            debugMethod();
            [NSException raise:@"Fetch failed"
                        format:@"Reason: %@", [error localizedDescription]];
        }
        
        allItemCategorys = [[NSMutableArray alloc] initWithArray:result];
    }
}

- (TCItemCategory*)createItemCategory
{
    TCItemCategory *ic = [NSEntityDescription insertNewObjectForEntityForName:@"TCItemCategory" inManagedObjectContext:self.context];
    [allItemCategorys addObject:ic];
    return ic;
}

- (void)removeItemCategory:(TCItemCategory*)itemCategpry
{
    [self.context deleteObject:itemCategpry];
    [allItemCategorys removeObject:itemCategpry];
}

#pragma mark - List

- (void)removeList:(TCList*)p
{
    [self.context deleteObject:p];
    [allLists removeObject:p];
}

- (NSArray *)allList
{
    return allLists;
}

- (TCList *)createList
{
    TCList *l = [NSEntityDescription insertNewObjectForEntityForName:@"TCList" inManagedObjectContext:self.context];
    [allLists addObject:l];
    return l;
}

- (void)loadAllLists
{
    if (!allLists)
    {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *e = [NSEntityDescription entityForName:@"TCList" inManagedObjectContext:_context];
        [request setEntity:e];
        
        //        NSSortDescriptor *sd = [NSSortDescriptor
        //                                sortDescriptorWithKey:@"orderingValue"
        //                                ascending:YES];
        //        [request setSortDescriptors:[NSArray arrayWithObject:sd]];
        
        NSError *error;
        NSArray *result = [self.context executeFetchRequest:request error:&error];
        if (!result)
        {
            debugMethod();
            [NSException raise:@"Fetch failed"
                        format:@"Reason: %@", [error localizedDescription]];
        }
        
        allLists = [[NSMutableArray alloc] initWithArray:result];
    }
}

#pragma mark - listCategory

- (void)removeListCategory:(TCListCategory*)listCategory
{
    [self.context deleteObject:listCategory];
    [allListCategorys removeObject:listCategory];
}

- (NSArray*)allListCategorys
{
    return allListCategorys;
}

- (TCListCategory*)createListCategory
{
    TCListCategory *lc = [NSEntityDescription insertNewObjectForEntityForName:@"TCListCategory" inManagedObjectContext:self.context];
    [allListCategorys addObject:lc];
    return lc;
}

- (void)loadAllListCategorys
{
    if (!allListCategorys)
    {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *e = [NSEntityDescription entityForName:@"TCListCategory" inManagedObjectContext:_context];
        [request setEntity:e];
        
        //        NSSortDescriptor *sd = [NSSortDescriptor
        //                                sortDescriptorWithKey:@"orderingValue"
        //                                ascending:YES];
        //        [request setSortDescriptors:[NSArray arrayWithObject:sd]];
        
        NSError *error;
        NSArray *result = [self.context executeFetchRequest:request error:&error];
        if (!result)
        {
            debugMethod();
            [NSException raise:@"Fetch failed"
                        format:@"Reason: %@", [error localizedDescription]];
        }
        
        allListCategorys = [[NSMutableArray alloc] initWithArray:result];
    }
    
}


- (BOOL)saveChanges
{
    NSError *err = nil;
    BOOL successful = [self.context save:&err];
    if (!successful) {
        NSLog(@"Error saving: %@", [err localizedDescription]);
    }
    return successful;
}

- (NSString*)dbPath
{
    NSArray *documentDirectories =
    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:@"TCDataStore.sqlite"];
}

- (void)test
{
    for(int i = 0; i < 20; i++)
    {
        TCItemCategory *oneIC = [self createItemCategory];
        TCListCategory *oneLC = [self createListCategory];
        TCItemProperty *oneIP = [self createItemProperty];
        TCItem *oneI = [self createItem];
        TCList *oneL = [self createList];
        [oneIC setValue:[NSString stringWithFormat:@"ItemCategory NO.%d",i] forKey:@"name"];
        [oneLC setValue:[NSString stringWithFormat:@"ListCategory NO.%d",i] forKey:@"name"];
        [oneIP setValue:[NSString stringWithFormat:@"ItemProperty NO.%d",i] forKey:@"name"];
        [oneI setValue:oneIP forKey:@"itemProperty"];
        [oneIP setValue:oneIC forKey:@"category"];
        [oneL addItemArrayObject:oneI];
        [oneL setValue:[NSString stringWithFormat:@"List No.%d",i] forKey:@"name"];
        
    }
}
@end
