//
//  OpenFileViewController.h
//  FilesAndFolders
//
//  Created by Vitaliy Dragun on 1/18/15.
//  Copyright (c) 2015 Vitaliy Dragun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileManager.h"

@interface OpenFileViewController : UIViewController

@property (strong, nonatomic) FileManager *dataSource;

- (instancetype)initWithDataSource:(FileManager*)fileManager;

@end
