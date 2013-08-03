//
//  TCItemProperty.h
//  TCListSoft
//
//  Created by 徐 哲 on 13-7-30.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TCItemCategory;

@interface TCItemProperty : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSData * thumbnailData;
@property (nonatomic, retain) UIImage * thumbnail;
@property (nonatomic) NSTimeInterval createdDate;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) TCItemCategory *category;

@end
