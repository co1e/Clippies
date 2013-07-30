//
//  PasteImageStore.m
//  UnnamedPasteboardApplication
//
//  Created by Thomas Cole on 7/27/13.
//  Copyright (c) 2013 co1e. All rights reserved.
//

#import "PasteImageStore.h"

@implementation PasteImageStore
+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedStore];
}

+ (PasteImageStore *)sharedStore
{
    static PasteImageStore * sharedStore;
    if (!sharedStore)
        sharedStore = [[super allocWithZone:NULL] init];
    return sharedStore;
}

- (id)init
{
    self = [super init];
    if (self) {
        dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)setImage:(UIImage *)i forKey:(NSString *)s
{
    [dictionary setObject:i forKey:s];
    NSString *imagePath = [self imagePathForKey:s];
    NSData *d = UIImagePNGRepresentation(i);
    [d writeToFile:imagePath atomically:YES];
}

- (UIImage *)imageForKey:(NSString *)s
{
    UIImage * theImageForTheKey = [dictionary objectForKey:s];
    if (!theImageForTheKey)
    {
        theImageForTheKey = [UIImage imageWithContentsOfFile:[self imagePathForKey:s]];
        
        if (theImageForTheKey) {
            [dictionary setObject:theImageForTheKey forKey:s];
        } else {
            NSLog(@"Error: unable to find %@", [self imagePathForKey:s]);
        }
    }
    return theImageForTheKey;
}

- (NSString *)imagePathForKey:(NSString *)key
{
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:key];
}
@end
