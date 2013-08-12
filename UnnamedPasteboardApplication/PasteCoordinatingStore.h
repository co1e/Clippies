//
//  PasteCoordinatingStore.h
//  UnnamedPasteboardApplication
//
//  Created by Thomas Cole on 7/27/13.
//  Copyright (c) 2013 co1e. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Paste;

@interface PasteCoordinatingStore : NSObject
{
    NSManagedObjectContext *context;
    NSManagedObjectModel *model;
    NSMutableArray * allFolders;
    NSTimer *timer;
}
@property (strong, nonatomic) NSMutableArray * allPastes;
@property (strong, nonatomic) NSMutableArray * allFolders;
@property (strong, nonatomic) NSMutableArray * pasteboardContents;

+ (PasteCoordinatingStore *)sharedStore;
- (Paste *)createPaste;
- (void)createFolder:(NSString *)folderName;
- (void)loadAllPastes;
- (NSArray *)allFolders;
- (void)removePaste:(Paste *)p;
- (NSString *)pasteArchivePath;
- (void)startMonitoringForPasteboardChangesInBackground;
- (BOOL)saveChanges;

@end
