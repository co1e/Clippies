//
//  PasteStringStore.m
//  UnnamedPasteboardApplication
//
//  Created by Thomas Cole on 7/27/13.
//  Copyright (c) 2013 co1e. All rights reserved.
//

#import "PasteStringStore.h"

@implementation PasteStringStore
@synthesize allPastes;
+ (PasteStringStore *)sharedStore {
    static PasteStringStore * sharedStore = nil;
    
    if (!sharedStore) {
        sharedStore = [[PasteStringStore alloc] init];
    }
    
    return sharedStore;
}

- (id)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addString:) name:UIPasteboardChangedNotification object:nil];
        
        if (!allPastes)
            allPastes = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addString:(NSNotification *)note
{
    
}

- (void)addImage:(id)sender
{
    
}

- (void)addPaste:(NSString *)item
{
    [allPastes addObject:item];
}

@end
