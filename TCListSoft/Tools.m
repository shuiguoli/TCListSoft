//
//  Tools.m
//  listWork
//
//  Created by 徐 哲 on 13-7-19.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import "Tools.h"
@implementation Tools
//+(UIImage*) imageFromPath:(NSString*)path
//{
//    NSArray *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSString *imagePath = [NSString stringWithFormat:@"%@%@%@",documentPath,@"/images/",path];
//    UIImage * image = [UIImage imageWithContentsOfFile:imagePath];
//    return image;
//}
//
//+(NSString*) imagePath:(UIImage*)picture
//{
//    FMDatabase *db = [DbManager sharedManager].db;
//    if(![db executeQuery:@"select * from images"])
//    {
//        [db executeUpdate:@"insert table images (unique_id integer, pic_path string"];
//    }
//    FMResultSet *rs = [db executeQuery:@"select max(unique_id) from images"];
//    [rs next];
//    int count = [rs intForColumn:@"unique_id"] + 1;
//    NSString *string =[NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
//    NSString *imagePath = [string stringByAppendingPathComponent:[[NSString alloc] initWithFormat:@"%i",count]];
//    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentPath =[NSString stringWithFormat:@"%@%@%@",[documents objectAtIndex:0],@"/images/",imagePath];
//    BOOL result = [UIImageJPEGRepresentation(picture, 0.5) writeToFile:documentPath atomically:YES];
//    if(result)
//    {
//        return imagePath;
//    }
//    else
//    {
//        return @"error";
//    }
//}

+(NSString*) randomString
{
    NSArray* randomStringList = [NSArray arrayWithObjects:@"constrl",@"tags",@"items",@"images",@"object",@"lists", nil];
    NSInteger stringIndex = rand() % [randomStringList count];
    NSString *randomString = [NSString stringWithFormat:@"%@ %i",[randomStringList objectAtIndex:stringIndex],rand() % 100];
    return randomString;
}

+(NSString*) stringFromDate:(NSDate *)date
{
    if(date == [NSNull null])
        return @"";
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:date];
}
+(NSDate*) dateFromString:(NSString*)string
{
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter dateFromString:string];
}
@end
