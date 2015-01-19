//
//  ImageViewController.h
//  FilesAndFolders
//
//  Created by Vitaliy Dragun on 1/18/15.
//  Copyright (c) 2015 Vitaliy Dragun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OpenFileViewController.h"
#import "FileManager.h"

@interface OpenImageFileViewController : OpenFileViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
