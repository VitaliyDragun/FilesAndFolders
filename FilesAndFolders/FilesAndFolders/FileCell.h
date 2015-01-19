//
//  FileCell.h
//  FilesAndFolders
//
//  Created by Vitaliy Dragun on 1/17/15.
//  Copyright (c) 2015 Vitaliy Dragun. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *cellReuseIdentifier = @"FileCell";

@interface FileCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageviewIcon;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewDisclosure;
@property (weak, nonatomic) IBOutlet UILabel *labelFilesNumber;
@end
