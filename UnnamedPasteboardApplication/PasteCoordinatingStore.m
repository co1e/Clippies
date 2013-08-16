//
//  PasteCoordinatingStore.m
//  UnnamedPasteboardApplication
//
//  Created by Thomas Cole on 7/27/13.
//  Copyright (c) 2013 co1e. All rights reserved.
//

#import "PasteCoordinatingStore.h"
#import "Paste.h"

@implementation PasteCoordinatingStore
@synthesize allPastes, allFolders, imagePastes, textPastes;

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedStore];
    
}

+ (PasteCoordinatingStore *)sharedStore {
    static PasteCoordinatingStore * sharedStore = nil;
    
    if (!sharedStore) {
        sharedStore = [[super allocWithZone:NULL] init];
    }
    
    return sharedStore;
}

- (id)init {
    self = [super init];
    
    if (self) {
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pastesChanged:) name:NSPersistentStoreDidImportUbiquitousContentChangesNotification object:nil];
//        
//        NSFileManager *fm = [NSFileManager defaultManager];
//        NSURL *ubiquityContainer = [fm URLForUbiquityContainerIdentifier:nil];
//        NSMutableDictionary *ubOptions = [NSMutableDictionary dictionary];
//        [ubOptions setObject:@"Clippings" forKey:NSPersistentStoreUbiquitousContentNameKey];
//        [ubOptions setObject:ubiquityContainer forKey:NSPersistentStoreUbiquitousContentURLKey];
        
        context = [[NSManagedObjectContext alloc] init];
        model = [NSManagedObjectModel mergedModelFromBundles:nil];
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];

        NSString *path = self.pasteArchivePath;
        NSURL *persStoreURL = [NSURL fileURLWithPath:path];
        
        NSError *error;
        if(![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:persStoreURL options:nil error:&error])
            {
                [NSException raise:@"Could not open!" format:@"%@", [error localizedDescription]];
            }
        
        context.persistentStoreCoordinator = psc;
        context.undoManager = nil;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startMonitoringForPasteboardChangesInBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveChanges) name:UIApplicationDidBecomeActiveNotification object:nil];
        
//        NSLog(@"User defaults: %@", [NSUserDefaults standardUserDefaults]);
        
        [self loadAllPastes];
    }
    
    return self;
}

#pragma mark - Create and destroy entities
- (Paste *)createPaste
{
    Paste *p = [NSEntityDescription insertNewObjectForEntityForName:@"Paste" inManagedObjectContext:context];
    [allPastes addObject:p];
    return p;
}

- (void)removePaste:(Paste *)p
{
    [allPastes removeObjectIdenticalTo:p];
    [context deleteObject:p];
}

- (void)createFolder:(NSString *)folderName
{
    NSManagedObject *folder;
    folder = [NSEntityDescription insertNewObjectForEntityForName:@"Folder" inManagedObjectContext:context];
    [folder setValue:folderName forKey:@"name"];
}

#pragma mark - Methods to load up data structures

//- (void)loadTextPastes
//{
//    if (!textPastes) {
//        NSFetchRequest * request = [[NSFetchRequest alloc] init];
//        NSEntityDescription * e = [[model entitiesByName] objectForKey:@"Paste"];
//        
//        request.entity = e;
//        
//        NSError *error;
//        NSArray * result = [context executeFetchRequest:request error:&error];
//        
//        if (!result) {
//            [NSException raise:@"Fetch failed" format:@"with Error: %@", error.localizedDescription];
//        }
//        
//        NSArray * resultArray = [[NSMutableArray alloc] initWithArray:result];
//        imagePastes = [[resultArray filteredArrayUsingPredicate:predicate] mutableCopy];
//    }
//}
//
//- (void)loadImagePastes
//{
//    if (!imagePastes) {
//    }
//}

- (void)loadAllPastes
{
    if (!allPastes) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *e = [[model entitiesByName] objectForKey:@"Paste"];
        
        request.entity = e;
        
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"type" ascending:YES];
        
        request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        
        NSError *error;
        NSArray *result = [context executeFetchRequest:request error:&error];
        
        if (!result) {
            [NSException raise:@"Fetch failed" format:@"with Error: %@", [error localizedDescription]];
        }
        
        allPastes = [[NSMutableArray alloc] initWithArray:result];
        
        NSString * imageType = @"image";
        NSString * textType = @"text";
        
        NSPredicate * filterForText = [NSPredicate predicateWithFormat:@"type == %@", textType];
        NSPredicate * filterForImages = [NSPredicate predicateWithFormat:@"type == %@", imageType];
        
        request.predicate = filterForText;
        result = [context executeFetchRequest:request error:&error];
        textPastes = [[NSMutableArray alloc] initWithArray:result];
        
        request.predicate = filterForImages;
        result = [context executeFetchRequest:request error:&error];
        imagePastes = [[NSMutableArray alloc] initWithArray:result];
    }
    NSLog(@"%@", imagePastes);
//    NSLog(@"%@", textPastes);
}

- (NSArray *)allFolders
{
    NSLog(@"Beginning of allFolders method: %@", allFolders);
    if (!allFolders) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *e = [[model entitiesByName] objectForKey:@"Folder"];
        
        request.entity = e;
        
        NSError *error;
        NSArray *result = [context executeFetchRequest:request error:&error];
        
        if (!result) {
            [NSException raise:@"Fetch failed" format:@"with Error: %@", [error localizedDescription]];
        }
        
        allFolders = [result mutableCopy];
    }
    
    if (allFolders.count == 0) {
        NSManagedObject *folder;
        
        folder = [NSEntityDescription insertNewObjectForEntityForName:@"Folder" inManagedObjectContext:context];
        [folder setValue:@"Clippies Instructions" forKey:@"name"];
        [allFolders addObject:folder];
    }
    NSLog(@"End of allFolders method: %@", allFolders);
    return allFolders;
}

#pragma mark - Monitor pasteboard in background

- (void)startMonitoringForPasteboardChangesInBackground
{
    UIPasteboard *gpb = [UIPasteboard generalPasteboard];
    UIApplication *application = [UIApplication sharedApplication];
    
    __block UIBackgroundTaskIdentifier task;
    
    task = [application beginBackgroundTaskWithExpirationHandler:^{
        NSLog(@"Background task ended.");
        NSArray *oldLocalNotifications = application.scheduledLocalNotifications;
        
        if (oldLocalNotifications > 0) {
            [application cancelAllLocalNotifications];
        }
        
        UILocalNotification *appWasTerminated = [[UILocalNotification alloc] init];
        
        if (appWasTerminated) {
            appWasTerminated.repeatInterval = 0;
            appWasTerminated.alertAction = @"Restart Application";
            appWasTerminated.alertBody = @"Background session ended. Open again to start a new background session.";
        }
        [application presentLocalNotificationNow:appWasTerminated];
        
        [application endBackgroundTask:task];
    }];
    
    if (task == UIBackgroundTaskInvalid) {
        NSLog(@"System refuses to allow background task");
        return;
    }
    
    NSArray *oldLocalNotifications = application.scheduledLocalNotifications;
    if (oldLocalNotifications > 0) {
        [application cancelAllLocalNotifications];
    }
    UILocalNotification *appEnteredBackground = [[UILocalNotification alloc] init];
    if (appEnteredBackground) {
        appEnteredBackground.repeatInterval = 0;
        appEnteredBackground.alertBody = @"App entered background, start copying things!";
    }
    [application presentLocalNotificationNow:appEnteredBackground];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *pasteboardContents = [NSMutableArray array];
        int changeCountWhenEnteringBackground = gpb.changeCount;
        
            // Check to see if the application is in the background, if it isn't, kill the background task
            while (application.applicationState == UIApplicationStateBackground) {
//                NSLog(@"background time remaining in %.0f sec (min: ~%d)", application.backgroundTimeRemaining , (int)application.backgroundTimeRemaining / 60);
                if (changeCountWhenEnteringBackground < gpb.changeCount) {
                    if ([gpb containsPasteboardTypes:[NSArray arrayWithObject:@"public.jpeg"]] && ![pasteboardContents containsObject:[gpb dataForPasteboardType:@"public.jpeg"]])
                    {
                        if (![self->allPastes containsObject:[gpb dataForPasteboardType:@"public.jpeg"]]) {
                            [pasteboardContents addObject:[gpb dataForPasteboardType:@"public.jpeg"]];
                            Paste *p = [self createPaste];
                            p.data = [gpb dataForPasteboardType:@"public.jpeg"];
                            p.type = @"image";
                            NSLog(@"Added something.");
                        }
                    }
                    else if ([gpb containsPasteboardTypes:[NSArray arrayWithObject:@"public.png"]] && ![pasteboardContents containsObject:[gpb dataForPasteboardType:@"public.png"]])
                    {
                        if (![self->allPastes containsObject:[gpb dataForPasteboardType:@"public.png"]]) {
                            [pasteboardContents addObject:[gpb dataForPasteboardType:@"public.png"]];
                            Paste *p = [self createPaste];
                            p.data = [gpb dataForPasteboardType:@"public.jpeg"];
                            p.type = @"image";
                            NSLog(@"Added something.");
                        }
                    }
                    else if ([gpb containsPasteboardTypes:[NSArray arrayWithObject:@"public.text"]] && ![pasteboardContents containsObject:[gpb dataForPasteboardType:@"public.text"]]) {
                        if (![self->allPastes containsObject:[gpb dataForPasteboardType:@"public.text"]]) {
                            [pasteboardContents addObject:[gpb dataForPasteboardType:@"public.text"]];
                            Paste *p = [self createPaste];
                            p.data = [gpb dataForPasteboardType:@"public.text"];
                            p.type = @"text";
                            NSLog(@"Added something.");
                        }
                    }
                }
            [NSThread sleepForTimeInterval:1];
            }
    });
}

#pragma mark - Misc

- (NSString *)pasteArchivePath
{
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:@"clippings.data"];
}

- (BOOL)saveChanges
{
    NSError *error;
    BOOL successful = [context save:&error];
    
    if (!successful) {
        NSLog(@"Error saving, %@", [error localizedDescription]);
    }
    
    NSLog(@"Saved changes successfully.");
    
    return successful;
}
@end