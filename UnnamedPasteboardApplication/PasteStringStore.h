//
//  PasteStringStore.h
//  UnnamedPasteboardApplication
//
//  Created by Thomas Cole on 7/27/13.
//  Copyright (c) 2013 co1e. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Pastes;

@interface PasteStringStore : NSObject
{
    NSManagedObjectContext *context;
    NSManagedObjectModel *model;
}
@property (strong, nonatomic) NSMutableArray * allPastes;

+ (PasteStringStore *)sharedStore;
- (Pastes *)createPaste;
- (void)loadAllPastes;
- (NSString *)pasteArchivePath;
- (void)addImageData:(NSString *)imgKey;
- (BOOL)saveChanges;
@end
