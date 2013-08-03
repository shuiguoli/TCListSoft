//
//  Tools.h
//  listWork
//
//  Created by 徐 哲 on 13-7-19.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools : NSObject
//+(UIImage*) imageFromPath:(NSString*)path;
//
//+(NSString*) imagePath:(UIImage*)picture;
+(NSString*) randomString;
+(NSString*) stringFromDate:(NSDate*)date;
+(NSDate*) dateFromString:(NSString*)string;
@end
