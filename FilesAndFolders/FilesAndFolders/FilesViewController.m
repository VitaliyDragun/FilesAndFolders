//
//  ViewController.m
//  FilesAndFolders
//
//  Created by Vitaliy Dragun on 1/17/15.
//  Copyright (c) 2015 Vitaliy Dragun. All rights reserved.
//

#import "FilesViewController.h"
#import "FileCell.h"
#import "OpenImageFileViewController.h"
#import "OpenTextFileViewController.h"

@interface FilesViewController ()

@property (strong, nonatomic) FileManager *fileManager;

@end

@implementation FilesViewController

- (instancetype)initWithDataSource:(FileManager*)dataSorce
{
    if (self = [super init])
    {
        self.fileManager = dataSorce;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FileCell" bundle:nil] forCellReuseIdentifier:cellReuseIdentifier];
   
    self.buttonBack.hidden = YES;
    
    self.labelTitle.text = [self.fileManager getOpenedFolderTitle];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.viewTopBar.layer.shadowOpacity = 0.5;
}

#pragma mark - Action Handlers

- (IBAction)onBack:(id)sender
{
    [self.fileManager moveToParentFolder];
    
    self.labelTitle.text = [self.fileManager getOpenedFolderTitle];
    
    [self.tableView reloadData];
    
    if ([self.fileManager isOpenedFolderRootFolder])
        self.buttonBack.hidden = YES;
}

- (IBAction)onSearch:(id)sender
{
    if (sender == self.buttonPhotos)
        [self.fileManager findAllFilesOFType:keyFileTypeImage];
    else if (sender == self.buttonTexts)
        [self.fileManager findAllFilesOFType:keyFileTypeText];
    
    [self.tableView reloadData];
    
    self.buttonBack.hidden = NO;
    
    self.labelTitle.text = [self.fileManager getOpenedFolderTitle];
}

#pragma mark - UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.fileManager getNumberOfFilesInOpenedFolder].integerValue;
}

- (FileCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FileCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];

    if (cell == nil)
        cell = [[FileCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellReuseIdentifier];
    
    cell.labelTitle.text = [self.fileManager getTitleOfFileWithIndex:indexPath.row];
    cell.imageviewIcon.image = [self.fileManager getIconOfFileWithIndex:indexPath.row];
    
    NSString *fileType = [self.fileManager getTypeOfFileWithIndex:indexPath.row];
    if ([fileType isEqualToString:keyFileTypeFolder])
    {
        cell.labelFilesNumber.hidden = NO;
        cell.labelFilesNumber.text = [self.fileManager getNumberOfFilesInFolderWithIndex:indexPath.row].stringValue;
        
        cell.imageviewDisclosure.hidden = NO;
    }
    else
    {
        cell.labelFilesNumber.hidden = YES;
        cell.imageviewDisclosure.hidden = YES;
    }
    
    return cell;

}

//Added next to methods to get rid of warning:
//http://stackoverflow.com/questions/25822324/ios8-constraints-ambiguously-suggest-a-height-of-zero
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *fileType = [self.fileManager openItemWithIndex:indexPath.row];
    if ([fileType isEqualToString:keyFileTypeFolder])
    {
        [self.tableView reloadData];
        
        self.labelTitle.text = [self.fileManager getOpenedFolderTitle];
        
        self.buttonBack.hidden = NO;
    }
    else if ([fileType isEqualToString:keyFileTypeImage])
    {
        OpenImageFileViewController *imageViewController = [[OpenImageFileViewController alloc] initWithDataSource:self.fileManager];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imageViewController];
        [self presentViewController:navigationController animated:YES completion:nil];
    }
    else if ([fileType isEqualToString:keyFileTypeText])
    {
        OpenTextFileViewController *textViewController = [[OpenTextFileViewController alloc] initWithDataSource:self.fileManager];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:textViewController];
        [self presentViewController:navigationController animated:YES completion:nil];
    }
}

@end
