//
//  PasteTableViewController.m
//  UnnamedPasteboardApplication
//
//  Created by Thomas Cole on 7/27/13.
//  Copyright (c) 2013 co1e. All rights reserved.
//

#import "PasteTableViewController.h"

@implementation PasteTableViewController

- (id)init {
    self = [super init];
    if (self) {
        self.navigationItem.title = @"Clipboard";
    }
    return [self initWithStyle:UITableViewStylePlain];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%i", [indexPath row]];
    
    return cell;
}

@end
