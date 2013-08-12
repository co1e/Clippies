//
//  Paste.h
//  Clippings
//
//  Created by Thomas Cole on 8/8/13.
//  Copyright (c) 2013 co1e. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Paste : NSManagedObject

@property (nonatomic, retain) NSData * data;
@property (nonatomic) NSTimeInterval dateCreated;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSManagedObject *folder;
@property (nonatomic, retain) NSManagedObject *group;

@end
