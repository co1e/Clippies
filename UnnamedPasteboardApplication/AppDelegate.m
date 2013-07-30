//
//  AppDelegate.m
//  UnnamedPasteboardApplication
//
//  Created by Thomas Cole on 7/27/13.
//  Copyright (c) 2013 co1e. All rights reserved.
//

#import "AppDelegate.h"
#import "PasteTableViewController.h"
#import "PasteStringStore.h"
#import "PasteImageStore.h"
#import "MainViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
//    MainViewController *mvc = [[MainViewController alloc] init];
    PasteTableViewController *ptvc = [[PasteTableViewController alloc] init];
    UINavigationController *unc = [[UINavigationController alloc] initWithRootViewController:ptvc];
    self.window.tintColor = [UIColor colorWithRed:0.667 green:0.000 blue:0.000 alpha:1.000];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = unc;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    BOOL success = [[PasteStringStore sharedStore] saveChanges];
    
    if (!success) {
        NSLog(@"Could not save allPastes.");
    } else {
        NSLog(@"Saved allPastes");
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[NSNotificationCenter defaultCenter] addObserver:[PasteStringStore sharedStore] selector:@selector(addString:) name:UIPasteboardChangedNotification object:nil];
    UIPasteboard *gpb = [UIPasteboard generalPasteboard];
    NSLog(@"String: %@", gpb.string);
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//    UIPasteboard *gpb = [UIPasteboard generalPasteboard];
//    if (gpb.changeCount > 0) {
//        if (gpb.image) {
////            [[PasteImageStore sharedStore] setImage:gpb.image forKey:nil];
//            NSLog(@"Image: %@", gpb.image);
//        }
//        else if (gpb.string) {
//            NSLog(@"String: %@", gpb.string);
//        }
//        else if (gpb.URL) {
//            NSLog(@"%@", gpb.URL);
//        }
//        NSLog(@"General Pasteboard Change Count: %i", gpb.changeCount);
//        NSLog(@"Pasteboard Types: %@", gpb.pasteboardTypes);
//    } else {
//        NSLog(@"There were no changes to the pasteboard contents");
//    }
}

- (void)addString:(id)sender
{
    NSLog(@"Notification triggered.");
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
