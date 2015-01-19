//
//  AppDelegate.m
//  FilesAndFolders
//
//  Created by Vitaliy Dragun on 1/17/15.
//  Copyright (c) 2015 Vitaliy Dragun. All rights reserved.
//

#import "AppDelegate.h"
#import "FilesViewController.h"
#import "FileManager.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    FileManager *fileManager = [[FileManager alloc] initWithJSONFileNamed:@"FileStructure"];
    
    FilesViewController *fileViewController = [[FilesViewController alloc] initWithDataSource:fileManager];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.rootViewController = fileViewController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
