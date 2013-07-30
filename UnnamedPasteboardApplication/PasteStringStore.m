//
//  PasteStringStore.m
//  UnnamedPasteboardApplication
//
//  Created by Thomas Cole on 7/27/13.
//  Copyright (c) 2013 co1e. All rights reserved.
//

#import "PasteStringStore.h"
#import "Pastes.h"

@implementation PasteStringStore
@synthesize allPastes;

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedStore];
}

+ (PasteStringStore *)sharedStore {
    static PasteStringStore * sharedStore = nil;
    
    if (!sharedStore) {
        sharedStore = [[super allocWithZone:NULL] init];
    }
    
    return sharedStore;
}

- (id)init {
    self = [super init];
    if (self) {
        if (!allPastes)
            allPastes = [[NSMutableArray alloc] init];
        
        // All that core data sheeeeeeit
        context = [[NSManagedObjectContext alloc] init];
        
        model = [NSManagedObjectModel mergedModelFromBundles:nil];
        
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
        
        // Call method that returns the path for data
        NSString *path = self.pasteArchivePath;
        NSURL *persStoreURL = [NSURL fileURLWithPath:path];
        
        NSError *error;
        
        if(![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:persStoreURL options:nil error:&error])
            {
                [NSException raise:@"Could not open!" format:@"%@", [error localizedDescription]];
            }
        
        context.persistentStoreCoordinator = psc;
        
        context.undoManager = nil;
    }
    return self;
}


- (Pastes *)createPaste
{
    Pastes *p = [NSEntityDescription insertNewObjectForEntityForName:@"Pastes" inManagedObjectContext:context];

    [allPastes addObject:p];
    return p;
}

- (void)addImageData:(NSString *)imgKey
{
    NSManagedObject *imageKey;
    
    imageKey = [NSEntityDescription insertNewObjectForEntityForName:@"ImageData" inManagedObjectContext:context];
    [imageKey setValue:imgKey forKey:@"imageKey"];
    [allPastes addObject:imageKey];
}

#pragma mark - load data

- (void)loadAllPastes
{
    if (!allPastes) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *e = [[model entitiesByName] objectForKey:@"Pastes"];
        
        request.entity = e;
        
//        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"pasteID" ascending:YES];
        
//        request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        
        NSError *error;
        NSArray *result = [context executeFetchRequest:request error:&error];
        
        if (!result) {
            [NSException raise:@"Fetch failed" format:@"with Error: %@", [error localizedDescription]];
        }
        
        allPastes = [[NSMutableArray alloc] initWithArray:result];
    }
}

#pragma mark - Save and Path fluff

- (NSString *)pasteArchivePath
{
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:@"pastes.data"];
}

- (BOOL)saveChanges
{
    NSError *error;
    BOOL successful = [context save:&error];
    
    if (!successful) {
        NSLog(@"Error saving, %@", [error localizedDescription]);
    }
    
    return successful;
}
@end
