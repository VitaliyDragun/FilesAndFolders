//
//  ImageViewController.m
//  FilesAndFolders
//
//  Created by Vitaliy Dragun on 1/18/15.
//  Copyright (c) 2015 Vitaliy Dragun. All rights reserved.
//

#import "OpenImageFileViewController.h"

@implementation OpenImageFileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imageView.image = [self.dataSource getOpenedFileImage];
}

@end
