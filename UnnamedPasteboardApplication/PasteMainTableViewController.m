//
//  PasteMainTableViewController.m
//  UnnamedPasteboardApplication
//
//  Created by Thomas Cole on 8/3/13.
//  Copyright (c) 2013 co1e. All rights reserved.
//

#import "PasteMainTableViewController.h"
#import "PasteTableViewController.h"
#import "PasteCoordinatingStore.h"

@implementation PasteMainTableViewController

- (id)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        [[self navigationItem] setTitle:@"Home"];
        [[self navigationItem] setRightBarButtonItem:[self editButtonItem]];
        [[self navigationController] setToolbarHidden:NO];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[self navigationController] setToolbarHidden:NO animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRowsInThisSection = 0;
    if (section == 0) {
        numberOfRowsInThisSection = 1;
    }
    else if (section == 1) {
        numberOfRowsInThisSection = [[[PasteCoordinatingStore sharedStore] allFolders] count];
    }
    return numberOfRowsInThisSection;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 && indexPath.section == 0)
        return NO;
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle = [[NSString alloc] init];

    if (section == 1) {
        sectionTitle = @"Projects";
    }
    
    return sectionTitle;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:YES];
    if (editing == YES) {
        UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithTitle:@"Add Folder" style:UIBarButtonItemStylePlain target:self action:@selector(addFolder:)];
        [[self navigationItem] setLeftBarButtonItem:addBtn animated:YES];
    } else {
        [[self navigationItem] setLeftBarButtonItem:nil animated:YES];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    if(indexPath.row == 0 && indexPath.section == 0) {
        cell.textLabel.text = @"Clipboard";
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [[[[PasteCoordinatingStore sharedStore] allFolders] objectAtIndex:indexPath.row] valueForKey:@"name"]];
    }
    
    cell.textLabel.font = [UIFont fontWithName:@"Avenir-Light" size:18.0];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 && indexPath.section == 0) {
        PasteTableViewController *ptvc = [[PasteTableViewController alloc] init];
        [[self navigationController] pushViewController:ptvc animated:YES];
    }
}

@end
