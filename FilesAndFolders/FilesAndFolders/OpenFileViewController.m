//
//  OpenFileViewController.m
//  FilesAndFolders
//
//  Created by Vitaliy Dragun on 1/18/15.
//  Copyright (c) 2015 Vitaliy Dragun. All rights reserved.
//

#import "OpenFileViewController.h"

@implementation OpenFileViewController

- (instancetype)initWithDataSource:(FileManager*)fileManager
{
    if (self = [super init])
    {
        self.dataSource = fileManager;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style: UIBarButtonItemStyleBordered target:self action:@selector(onBack)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    self.navigationItem.title = [self.dataSource getOpenedFileTitle];
}

- (void)onBack
{
    [self.navigationController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
