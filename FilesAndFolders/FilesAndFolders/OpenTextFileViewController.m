//
//  TextViewController.m
//  FilesAndFolders
//
//  Created by Vitaliy Dragun on 1/18/15.
//  Copyright (c) 2015 Vitaliy Dragun. All rights reserved.
//

#import "OpenTextFileViewController.h"

@interface OpenTextFileViewController ()

@end

@implementation OpenTextFileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.textView.text = [self.dataSource getOpenedFileText];
}
@end
