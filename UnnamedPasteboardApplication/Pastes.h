//
//  Pastes.h
//  UnnamedPasteboardApplication
//
//  Created by Thomas Cole on 7/29/13.
//  Copyright (c) 2013 co1e. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Pastes : NSManagedObject

@property (nonatomic) NSTimeInterval dateCreated;
@property (nonatomic, retain) NSString * imageKey;
@property (nonatomic) int64_t pasteID;
@property (nonatomic, retain) NSString * stringData;
@property (nonatomic, retain) NSString * urlData;
@property (nonatomic, retain) NSManagedObject *relationship;

@end
