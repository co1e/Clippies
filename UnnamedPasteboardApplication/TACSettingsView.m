//
//  TACSettingsView.m
//  Clippings
//
//  Created by Thomas Cole on 8/12/13.
//  Copyright (c) 2013 co1e. All rights reserved.
//

#import "TACSettingsView.h"

@implementation TACSettingsView

- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
//        [[self tableView] setContentInset:UIEdgeInsetsMake(60, 0, 0, 0)];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    UIToolbar * tb = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    UIBarButtonItem * space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissSettingsView:)];
//    [self setToolbarItems:[NSArray arrayWithObjects:space, doneButton, nil] animated:YES];
    [tb setItems:[NSArray arrayWithObjects:space, doneButton, nil] animated:YES];
    [tb setBarStyle:UIBarStyleBlackTranslucent];
    [tb setBackgroundImage:nil forToolbarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    [[self view] addSubview:tb];
    
//    [self setEdgesForExtendedLayout:]
}

- (void)dismissSettingsView:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfCells = 0;
    if (section == 0) {
        numberOfCells = 1;
    }
    return numberOfCells;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"Run in background?";
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
        cell.detailTextLabel.text = @"* Required to copy while in background";
        cell.accessoryView = [[UISwitch alloc] initWithFrame:CGRectZero];
    }
    if (indexPath.row == 1) {
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.text = @"Done";
        cell.textLabel.layer.borderColor = [UIColor blackColor].CGColor;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        [self dismissViewControllerAnimated:YES completion:^{
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
        }];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle = @"";
    if (section == 0) {
        sectionTitle = @"Settings";
    }
    return sectionTitle;
}

@end
