//
//  TACAddFolderViewController.m
//  Clippings
//
//  Created by Thomas Cole on 8/12/13.
//  Copyright (c) 2013 co1e. All rights reserved.
//

#import "TACMoveToFolderViewController.h"
#import "PasteCoordinatingStore.h"

@implementation TACMoveToFolderViewController
- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
         self.navigationItem.title = @"Add Folder";
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger sectionCount = 0;
    if (section == 0)
        sectionCount = [[[PasteCoordinatingStore sharedStore] allFolders] count];
    else if (section == 1)
        sectionCount = 1;
    return sectionCount;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString * sectionTitle = @"";
    if (section == 0) {
        sectionTitle = @"Current Folders";
    }
    return sectionTitle;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = [[[[PasteCoordinatingStore sharedStore] allFolders] objectAtIndex:indexPath.row] valueForKey:@"name"];
    }
    
    if (indexPath.section == 1)
    {
        cell.textLabel.text = @"Add Folder";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
