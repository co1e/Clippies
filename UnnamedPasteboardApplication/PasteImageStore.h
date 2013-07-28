//
//  PasteImageStore.h
//  UnnamedPasteboardApplication
//
//  Created by Thomas Cole on 7/27/13.
//  Copyright (c) 2013 co1e. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PasteImageStore : NSObject
{
    NSMutableDictionary *dictionary;
}

+ (PasteImageStore *)sharedStore;
- (UIImage *)imageForKey:(NSString *)s;
- (void)setImage:(UIImage *)i forKey:(NSString *)s;
- (NSString *)imagePathForKey:(NSString *)key;
@end
