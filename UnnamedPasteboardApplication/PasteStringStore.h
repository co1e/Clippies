//
//  PasteStringStore.h
//  UnnamedPasteboardApplication
//
//  Created by Thomas Cole on 7/27/13.
//  Copyright (c) 2013 co1e. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PasteStringStore : NSObject
@property (strong, nonatomic) NSMutableArray * allPastes;

+ (PasteStringStore *)sharedStore;
- (void)addPaste:(NSString *)paste;
@end
