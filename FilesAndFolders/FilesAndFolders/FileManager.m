//
//  DataSource.m
//  FilesAndFolders
//
//  Created by Vitaliy Dragun on 1/17/15.
//  Copyright (c) 2015 Vitaliy Dragun. All rights reserved.
//

#import "FileManager.h"

@interface FileManager ()

@property (strong, nonatomic) NSArray *filesToDisplay;          //Files that are visible in FilesViewController

@property (strong, nonatomic) NSMutableArray *folderStack;      //Is used for navigation between folders

@property (strong, nonatomic) NSDictionary *openedFolder;

@property (strong, nonatomic) NSDictionary *openedFile;

@property (strong, nonatomic) NSMutableDictionary *folderForSearchResults;

@end

@implementation FileManager

- (instancetype)initWithJSONFileNamed:(NSString*)fileName
{
    if (self = [super init])
    {
        NSError *error;
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
        
        NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
        
        NSDictionary *rootFolder = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        
        if (error)
        {
            NSLog(@"Error parcing json: %@", error);
            abort();
        }
        
        self.openedFolder = rootFolder;
        
        self.folderStack = [[NSMutableArray alloc] initWithObjects:self.openedFolder, nil];
        
        self.filesToDisplay = [self.openedFolder objectForKey:keyFiles];
    }
    
    return self;
}

#pragma mark

- (NSString*)openItemWithIndex:(NSInteger)index
{
    NSDictionary *fileToOpen = [self.filesToDisplay objectAtIndex:index];
    NSString *fileType = [fileToOpen objectForKey:keyFileType];
    
    if ([fileType isEqualToString:keyFileTypeFolder])
        [self openFolder:fileToOpen];
    else if ([fileType isEqualToString:keyFileTypeImage] || [fileType isEqualToString:keyFileTypeText])
        self.openedFile = fileToOpen;
    
    return fileType;
}

- (void)moveToParentFolder
{
    [self.folderStack removeLastObject];
    
    self.openedFolder = [self.folderStack lastObject];
    
    self.filesToDisplay = [self.openedFolder objectForKey:keyFiles];
}

- (BOOL)isOpenedFolderRootFolder
{
    if (self.folderStack.count == 1)
        return YES;
    else
        return NO;
}

- (void)findAllFilesOFType:(NSString*)typeToFind
{
    if (self.folderForSearchResults == [self.folderStack lastObject])
        [self moveToParentFolder];
    
    self.folderForSearchResults = [self createFolderWithName:[NSString stringWithFormat:@"%@ files", typeToFind]];
    
    NSDictionary *rootFolder = [self.folderStack objectAtIndex:0];
    
    self.folderForSearchResults[keyFiles] = [self findAllFilesOFType:typeToFind
                                                    startingInFolder:rootFolder];
    [self openFolder:self.folderForSearchResults];
    
    self.filesToDisplay = [self.filesToDisplay sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2)
    {
        NSString *string1 = [obj1 objectForKey:keyFileName], *string2 = [obj2 objectForKey:keyFileName];
        return [string1 compare:string2 options:NSCaseInsensitiveSearch];
    }];
}

#pragma mark - Getters

- (NSString*)getTitleOfFileWithIndex:(NSInteger)index
{
    NSDictionary *file = [self.filesToDisplay objectAtIndex:index];
    return  [file objectForKey:keyFileName];
}

- (UIImage*)getIconOfFileWithIndex:(NSInteger)index
{
    NSDictionary *file = [self.filesToDisplay objectAtIndex:index];
    NSString *fileType = [file objectForKey:keyFileType];
    
    if ([fileType isEqualToString:keyFileTypeFolder])
        return [UIImage imageNamed:@"folder"];
    else if ([fileType isEqualToString:keyFileTypeText])
        return [UIImage imageNamed:@"texts"];
    else
    {
        NSString *imageFileName = [file objectForKey:keyFileName];
        return [UIImage imageNamed:imageFileName];
    }
}

- (NSString*)getTypeOfFileWithIndex:(NSInteger)index
{
    NSDictionary *file = [self.filesToDisplay objectAtIndex:index];
    return [file objectForKey:keyFileType];
}

- (NSNumber*)getNumberOfFilesInOpenedFolder
{
    return [NSNumber numberWithInteger:self.filesToDisplay.count];
}

- (NSNumber*)getNumberOfFilesInFolderWithIndex:(NSInteger)index
{
    NSDictionary *folder = [self.filesToDisplay objectAtIndex:index];
    NSArray *filesInFolder = [folder objectForKey:keyFiles];
    return [NSNumber numberWithInteger:filesInFolder.count];
}

- (NSString*)getOpenedFileText
{
    return [self.openedFile objectForKey:keyTextFileContent];
}

- (UIImage*)getOpenedFileImage
{
    NSString *imageName = [self.openedFile objectForKey:keyFileName];
    return [UIImage imageNamed:imageName];
}

- (NSString*)getOpenedFileTitle
{
    return [self.openedFile objectForKey:keyFileName];
}

- (NSString*)getOpenedFileType
{
    return [self.openedFolder objectForKey:keyFileType];
}

- (NSString*)getOpenedFolderTitle
{
    return [self.openedFolder objectForKey:keyFileName];
}

#pragma mark - Private Methods

- (NSMutableDictionary*)createFolderWithName:(NSString*)folderName
{
    NSMutableDictionary *newFolder = [[NSMutableDictionary alloc] init];
    newFolder[keyFileType] = keyFileTypeFolder;
    newFolder[keyFileName] = folderName;
    
    return newFolder;
}

- (NSArray*)findAllFilesOFType:(NSString *)typeToFind
                  startingInFolder:(NSDictionary*)folder
{
    NSArray *filesInFolder = [folder objectForKey:keyFiles];
    
    if (!filesInFolder)
        return nil;
    
    NSMutableArray *foundFiles = [[NSMutableArray alloc] init];
    
    for (NSDictionary *file in filesInFolder)
    {
        if ([[file objectForKey:keyFileType] isEqualToString:typeToFind])
            [foundFiles addObject:file];
        if ([[file objectForKey:keyFileType] isEqualToString:keyFileTypeFolder])
            [foundFiles addObjectsFromArray:[self findAllFilesOFType:typeToFind startingInFolder:file]];
    }
    
    return foundFiles;
}

- (void)openFolder:(NSDictionary*)folderToOpen
{
    self.openedFolder = folderToOpen;
    
    self.filesToDisplay = [self.openedFolder objectForKey:keyFiles];
    
    [self.folderStack addObject:self.openedFolder];
}

@end
