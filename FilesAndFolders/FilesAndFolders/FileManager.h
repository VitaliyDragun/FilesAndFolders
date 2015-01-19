//
//  DataSource.h
//  FilesAndFolders
//
//  Created by Vitaliy Dragun on 1/17/15.
//  Copyright (c) 2015 Vitaliy Dragun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static NSString *keyFileName = @"name";
static NSString *keyFileType = @"type";
static NSString *keyFileTypeFolder = @"folder";
static NSString *keyFileTypeImage = @"image";
static NSString *keyFileTypeText = @"text";
static NSString *keyTextFileContent = @"content";
static NSString *keyFiles = @"files";

@interface FileManager : NSObject

- (instancetype)initWithJSONFileNamed:(NSString*)fileName;

- (NSString*)openItemWithIndex:(NSInteger)index;

- (void)moveToParentFolder;

- (BOOL)isOpenedFolderRootFolder;

- (void)findAllFilesOFType:(NSString*)typeToFind;

#pragma mark - Getters

- (NSNumber*)getNumberOfFilesInOpenedFolder;

- (NSString*)getTitleOfFileWithIndex:(NSInteger)index;

- (UIImage*)getIconOfFileWithIndex:(NSInteger)index;

- (NSString*)getTypeOfFileWithIndex:(NSInteger)index;

- (NSNumber*)getNumberOfFilesInFolderWithIndex:(NSInteger)index;

- (NSString*)getOpenedFolderTitle;

- (NSString*)getOpenedFileTitle;

- (NSString*)getOpenedFileText;

- (UIImage*)getOpenedFileImage;

@end
