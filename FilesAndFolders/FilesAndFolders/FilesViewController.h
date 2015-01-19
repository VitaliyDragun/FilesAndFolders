//
//  ViewController.h
//  FilesAndFolders
//
//  Created by Vitaliy Dragun on 1/17/15.
//  Copyright (c) 2015 Vitaliy Dragun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileManager.h"

@interface FilesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *viewTopBar;
@property (weak, nonatomic) IBOutlet UIButton *buttonBack;
@property (weak, nonatomic) IBOutlet UIButton *buttonTexts;
@property (weak, nonatomic) IBOutlet UIButton *buttonPhotos;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (instancetype)initWithDataSource:(FileManager*)dataSorce;

@end

