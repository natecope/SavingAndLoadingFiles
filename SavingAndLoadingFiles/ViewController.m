//
//  ViewController.m
//  SavingAndLoadingFiles
//
//  Created by Nathan Cope on 8/24/14.
//  Copyright (c) 2014 PlumChoice. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *filenameTextField;
@property (weak, nonatomic) IBOutlet UITextView *saveTextView;
@property (weak, nonatomic) IBOutlet UITextView *loadTextView;

@end

@implementation ViewController{
    NSArray *files;
}


- (NSString *)documentsDirectory {
    
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

- (NSString *)pathInDocumentsDirectory:(NSString *)filename{

    return [[self documentsDirectory] stringByAppendingPathComponent:filename];
    
}


- (IBAction)saveButtonPressed:(id)sender {

    [self.view endEditing:NO];
    
    // get the filename
    NSString *filename = self.filenameTextField.text;
    
    // create path
    NSString *path = [self pathInDocumentsDirectory:filename];
    
    // save data from textview
    NSError *error = nil;
    [self.saveTextView.text writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];

    if(error){
        self.loadTextView.text = [error localizedDescription];
    }
}

- (IBAction)loadButtonPressed:(id)sender {

    [self.view endEditing:NO];
    
    //filepath to load from
    NSString *filepath = [self pathInDocumentsDirectory:self.filenameTextField.text];
    
    
    //load the string data to the text area
    NSError *error = nil;
    
    NSString *loadedTextData = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:&error];
   
    self.loadTextView.text = loadedTextData;
    
    if(error){
        self.loadTextView.text = [error localizedDescription];
    }
    
    
    
}

- (NSArray *)getFileList{
    NSArray *fileList = [[NSArray alloc]init];
    
    NSFileManager *filemanager = [[NSFileManager alloc]init];
    
    NSError *error = nil;
    
    fileList = [filemanager contentsOfDirectoryAtPath:[self documentsDirectory] error:&error];
    
    return fileList;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //Get documents folder for app
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    NSLog(@"Document dir: %@", documentsDirectory);
    
    //Save nsstring to folder

    NSString *filename = @"text.txt";
    NSString *filepath = [documentsDirectory stringByAppendingPathComponent:filename];
    NSString *saveTextData = @"Every app has its own documents folder";
    
    NSLog(@"filepath: %@", filepath);
    
    NSError *error = nil;
    [saveTextData writeToFile:filepath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if(error){
        NSLog(@"Save error: %@", [error localizedDescription]);
    }
    //load nsstring from folder

    error = nil;
    NSString *loadedTextData = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:&error];
    
    if(error){
        NSLog(@"Load error: %@", [error localizedDescription]);
    }
    
    NSLog(@"Loaded text data: %@", loadedTextData);
    
    files = [self getFileList];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    

    
    return [files count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [files objectAtIndex:indexPath.row];
    
    return cell;
}

@end
