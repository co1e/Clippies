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
@property (strong, nonatomic) NSMutableArray * imagePastes;
@property (strong, nonatomic) NSMutableArray * textPastes;

+ (PasteCoordinatingStore *)sharedStore;
- (Paste *)createPaste;
- (void)createFolder:(NSString *)folderName;
//- (void)loadImagePastes;
//- (void)loadTextPastes;
- (void)loadAllPastes;
- (NSArray *)allFolders;
- (void)removePaste:(Paste *)p;
- (NSString *)pasteArchivePath;
- (void)startMonitoringForPasteboardChangesInBackground;
- (BOOL)saveChanges;

@end
