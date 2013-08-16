//
//  TACHomeTableViewController.h
//  UnnamedPasteboardApplication
//
//  Created by Thomas Cole on 8/3/13.
//  Copyright (c) 2013 co1e. All rights reserved.
//

#import "TACHomeTableViewController.h"
#import "PasteTableViewController.h"
#import "PasteCoordinatingStore.h"
#import "TACMoveToFolderViewController.h"
//#import "ClippingsSettingsView.h"
#import "TACCollectionViewController.h"
#import "TACSettingsView.h"

@implementation TACHomeTableViewController

- (id)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.navigationItem.title = @"Home";
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
        self.view.tintColor = [UIColor redColor];
    }
    return self;
}

- (void)viewDidLoad
{
    UIBarButtonItem *settingsBtn = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(presentSettingsView:)];
    settingsBtn.tintColor = [UIColor redColor];
    [self setToolbarItems:[NSArray arrayWithObjects:settingsBtn, nil] animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[self navigationController] setToolbarHidden:NO animated:YES];
    //    self.navigationController.toolbarItems = [NSArray arrayWithObject:settingsBtn];
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
        sectionTitle = @"Folders";
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

- (void)addFolder:(id)sender
{
    TACMoveToFolderViewController *afvc = [[TACMoveToFolderViewController alloc] init];
    [[self navigationController] pushViewController:afvc animated:YES];
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
    
    if ([tableView isEditing] == YES) {
        NSLog(@"Is editing.");
    }
    
    cell.textLabel.font = [UIFont fontWithName:@"Avenir-Light" size:18.0];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 && indexPath.section == 0) {
//        PasteTableViewController *ptvc = [[PasteTableViewController alloc] init];
        UICollectionViewFlowLayout *cvfl = [[UICollectionViewFlowLayout alloc] init];
        cvfl.minimumLineSpacing = 5.0f;
        cvfl.minimumInteritemSpacing = 10.0f;

        TACCollectionViewController *tac = [[TACCollectionViewController alloc] initWithCollectionViewLayout:cvfl];
        [[self navigationController] pushViewController:tac animated:YES];
    }
}

- (void)presentSettingsView:(id)sender
{
    TACSettingsView *settings = [[TACSettingsView alloc] init];
//    [[self navigationController] pushViewController:settings animated:YES];
    [settings setModalPresentationStyle:UIModalPresentationCurrentContext];
    [settings setProvidesPresentationContextTransitionStyle:YES];
    [self presentViewController:settings animated:YES completion:nil];
}

@end
