//
//  PasteTableViewController.m
//  UnnamedPasteboardApplication
//
//  Created by Thomas Cole on 7/27/13.
//  Copyright (c) 2013 co1e. All rights reserved.
//

#import "PasteTableViewController.h"
#import "PasteDetailView.h"
#import "PasteCoordinatingStore.h"
#import "Paste.h"
//#import "CustomPasteCell.h"
#import "TACPasteCell.h"
#import "TACMoveToFolderViewController.h"

//#define FONT_SIZE 14.0f
//#define CELL_CONTENT_WIDTH 320.0f
//#define CELL_CONTENT_MARGIN 10.0f

@interface PasteTableViewController()
{
    UILabel * copiedLabel;
}

@end

@implementation PasteTableViewController

- (id)init {
    return [self initWithStyle:UITableViewStylePlain];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.navigationItem.title = @"Clip List";
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
        
        [[self tableView] setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        
//        if ([[[PasteCoordinatingStore sharedStore] allPastes] count] == 0) {
//            [[[self view] layer] addSublayer:nil];
//        }
        
        [[NSNotificationCenter defaultCenter] addObserver:[self tableView] selector:@selector(reloadData) name:UIApplicationDidBecomeActiveNotification object:nil];
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(copyAlertDismiss:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"TACPasteCell" bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"TACPasteCell"];
    
//    CustomPasteCell * cell = [[CustomPasteCell alloc] init];    
//    [[self tableView] registerClass:cell.class forCellReuseIdentifier:@"CustomPasteCell"];
    
//    CAGradientLayer * gradient = [CAGradientLayer layer];
//    gradient.frame = CGRectMake(0, 0, 500, 500);
//    
//    UIColor *c1 = [UIColor colorWithRed:0.09 green:0.70 blue:0.98 alpha:1.0];
//    UIColor *c2 = [UIColor colorWithRed:0.07 green:0.41 blue:0.95 alpha:1.0];
//    UIColor *c3 = [UIColor colorWithRed:0.81 green:0.46 blue:0.93 alpha:1.0];
//    gradient.colors = @[(id)c2.CGColor, (id)c3.CGColor, (id)c3.CGColor];
//    
//    CABasicAnimation * anim = [CABasicAnimation animationWithKeyPath:@"colors"];
//    // This is really cool, cast to id in order to build an array literal (id is object of indeterminate type)
//    anim.toValue = @[(id)c1.CGColor, (id)c2.CGColor, (id)c2.CGColor];
//    anim.duration = 4.0;
//    anim.autoreverses = YES;
//    // Essentially loops until infinity (1 to the 100th power)
//    anim.repeatCount = 1e100;
//    [gradient addAnimation:anim forKey:@"colors"];
//    
//    [self.view.layer addSublayer:gradient];
//    self.tableView.separatorColor = [UIColor redColor];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setToolbarHidden:YES];
}

#pragma mark - Table View Stuff

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[PasteCoordinatingStore sharedStore] allPastes] count];
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    Paste *p = [[[PasteCoordinatingStore sharedStore] allPastes] objectAtIndex:[indexPath row]];
//    
//    CustomPasteCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CustomPasteCell"];
//    
//    if (!cell)
//    {
//        cell = [[CustomPasteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CustomPasteCell"];
//    }
//
//    if ([p.type isEqualToString:@"text"]) {
////        [cell.imageView removeFromSuperview];
//        cell.imageView.image = nil;
//        NSError *error;
//        cell.textLabel.attributedText = [[NSAttributedString alloc] initWithData:p.data options:nil documentAttributes:nil error:&error];
//    }
//    
//    else if ([p.type isEqualToString:@"image"])
//    {
//        cell.textLabel.attributedText = [[NSAttributedString alloc] initWithString:@""];
////        [cell.textLabel removeFromSuperview];
//        cell.imageView.image = [UIImage imageWithData:p.data];
//    }
//    
//    return cell;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Paste *p = [[[PasteCoordinatingStore sharedStore] allPastes] objectAtIndex:indexPath.row];
    
    TACPasteCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TACPasteCell"];
    
    if (![[p.folder valueForKey:@"name"] isEqualToString:@""]) {
        if ([p.type isEqualToString:@"text"]) {
            cell.iv.image = nil;
            NSError *error;
            cell.tl.attributedText = [[NSAttributedString alloc] initWithData:p.data options:nil documentAttributes:nil error:&error];
        }
        else if ([p.type isEqualToString:@"image"])
        {
            cell.tl.attributedText = [[NSAttributedString alloc] initWithString:@""];
            cell.iv.image = [UIImage imageWithData:p.data];
        }
    }
    
    return cell;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    if (editing == YES) {
//        UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPaste:)];
        UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addPaste:)];
        [[self navigationItem] setLeftItemsSupplementBackButton:NO];
        [[self navigationItem] setLeftBarButtonItem:addBtn animated:YES];
    } else {
        [self.navigationItem setLeftBarButtonItem:[[self navigationItem] backBarButtonItem] animated:YES];
//        self.navigationItem.leftBarButtonItem = [[self navigationItem] backBarButtonItem];
    }
}

- (void)addPaste:(id)sender
{
    Paste *p = [[PasteCoordinatingStore sharedStore] createPaste];
    PasteDetailView *pdv = [[PasteDetailView alloc] init];
    pdv.paste = p;
    [[self navigationController] pushViewController:pdv animated:YES];
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
//    
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
//    }
//    
//    Paste *p = [[[PasteCoordinatingStore sharedStore] allPastes] objectAtIndex:indexPath.row];
//    NSLog(@"Paste Data Type: %@", p.type);
//    
//    if ([p.type isEqualToString:@"text"]) {
////        cell.imageView.hidden = YES;
//        NSError *err;
//        cell.imageView.image = nil;
//        cell.textLabel.attributedText = [[NSAttributedString alloc] initWithData:p.data options:nil documentAttributes:nil error:&err];
//    }
//    else {
//        cell.textLabel.attributedText = [[NSAttributedString alloc] initWithString:@""];
//        cell.imageView.image = [UIImage imageWithData:p.data];
//    }
//    
//    return cell;
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Method stub for dynamic calculation of cell height
//    NSString *text = [[[PasteCoordinatingStore sharedStore] allPastes] objectAtIndex:indexPath.row];
//    
//    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
//    
////    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
//    
//    CGSize size = [text boundingRectWithSize:self.view.bounds.size options:NSStringDrawingTruncatesLastVisibleLine attributes:nil context:nil];
//    CGFloat height = MAX(size.height, 44.0f);
//    
//    return height + (4.0f * 2.0);
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 76.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//
//    // Array to store activity items.
//    NSArray *activityItems;
//    NSArray *excludedActivityTypes;
//    if (cell.textLabel.hidden == NO) {
//        activityItems = [NSArray arrayWithObject:cell.textLabel.text];
//        excludedActivityTypes = [NSArray arrayWithObjects:UIActivityTypeSaveToCameraRoll, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, nil];
//    } else {
//        activityItems = [NSArray arrayWithObject:cell.imageView.image];
//        excludedActivityTypes = [NSArray arrayWithObjects:UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, nil];
//    }
//    avc = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
//    avc.excludedActivityTypes = excludedActivityTypes;
//    // Present activity view
//    [self presentViewController:avc animated:YES completion:nil];
//    PasteDetailView *pdv = [[PasteDetailView alloc] init];
//    Paste *p = [[[PasteCoordinatingStore sharedStore] allPastes] objectAtIndex:[indexPath row]];
//    [pdv setPaste:p];
//    [self.navigationController pushViewController:pdv animated:YES];
    
//    NSError *error;
//    NSDataDetector *dd = [[NSDataDetector alloc] initWithTypes:NSTextCheckingTypeLink error:&error];
//    
//    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//    
//    NSString *string = cell.textLabel.text;
//    
//    if (string) {
//        NSTextCheckingResult * linkMatch = [dd firstMatchInString:string options:0 range:NSMakeRange(0, string.length)];
//        
//        NSLog(@"Link match: %@", [linkMatch URL]);
//        
//        NSString * openIn;
//        
//        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"googlechrome://"]]) {
//            openIn = @"Open in Chrome";
//        } else {
//            openIn = @"Open in Safari";
//        }
//        
//        if (linkMatch) {
//            actSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles: @"Edit", @"Copy", @"Share", @"Open in...", nil];
////            NSURL *url = [linkMatch URL];
////            [[UIApplication sharedApplication] openURL:url];
//        } else {
//        }
//    }
    actSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Edit", @"Copy", @"Share", @"Move To Folder", nil];
    [actSheet showInView:[self view]];
    [[self view] setTintColor:[UIColor grayColor]];
    [[self view] tintColorDidChange];
//    UITableViewCell * cell = [tableView cellForRowAtIndexPath:self.tableView.indexPathForSelectedRow];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Paste *p = [[[PasteCoordinatingStore sharedStore] allPastes] objectAtIndex:[indexPath row]];
        [[PasteCoordinatingStore sharedStore] removePaste:p];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actSheet.firstOtherButtonIndex) {
        PasteDetailView *pdv = [[PasteDetailView alloc] init];
        NSInteger selectedRow = self.tableView.indexPathForSelectedRow.row;
        Paste *p = [[[PasteCoordinatingStore sharedStore] allPastes] objectAtIndex:selectedRow];
        pdv.paste = p;

        [self.navigationController pushViewController:pdv animated:YES];
    }
    else if (buttonIndex == actSheet.firstOtherButtonIndex + 1)
    {
        // String to store conditional alertMessage.
        NSString *alertMessage = [[NSString alloc] init];
        
        NSIndexPath * selectedCellIndexPath = self.tableView.indexPathForSelectedRow;
        
        UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:selectedCellIndexPath];

        if (cell.textLabel.hidden == NO) {
            [[UIPasteboard generalPasteboard] setString:[NSString stringWithFormat:@"%@", cell.textLabel.attributedText]];
            alertMessage = @"Copied text!";
        } else {
            [[UIPasteboard generalPasteboard] setImage:cell.imageView.image];
            alertMessage = @"Copied image!";
        }
        
        av = [[UIAlertView alloc] initWithTitle:alertMessage message:nil delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [av show];
    }
    else if (buttonIndex == actSheet.firstOtherButtonIndex + 2)
    {
        NSIndexPath *selectedCellIndexPath = self.tableView.indexPathForSelectedRow;
        
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:selectedCellIndexPath];
        
        // Array to store activity items.
        NSArray *activityItems;
        
        if (cell.textLabel.hidden == NO) {
             activityItems = [NSArray arrayWithObject:cell.textLabel.attributedText];
        } else {
             activityItems = [NSArray arrayWithObject:cell.imageView.image];
        }
        
        // Present activity view
        avc = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
        avc.excludedActivityTypes = [NSArray arrayWithObjects:UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, nil];
        [self presentViewController:avc animated:YES completion:nil];
    }
    else if (buttonIndex == actSheet.firstOtherButtonIndex + 3) {
        // Present second action sheet.
//        UIActionSheet *as2 = [[UIActionSheet alloc] initWithTitle:@"Open in..." delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Chrome", @"Safari", nil];
//        [actSheet dismissWithClickedButtonIndex:actSheet.cancelButtonIndex animated:NO];
//        [as2 showInView:self.view];
        TACMoveToFolderViewController *afvc = [[TACMoveToFolderViewController alloc] init];
        [self.navigationController pushViewController:afvc animated:YES];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSIndexPath *selectedCellIndexPath = self.tableView.indexPathForSelectedRow;
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:selectedCellIndexPath];
    cell.selected = NO;
}

@end