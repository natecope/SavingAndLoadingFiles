//
//  ViewController.m
//  SavingAndLoadingFiles
//
//  Created by Nathan Cope on 8/24/14.
//  Copyright (c) 2014 PlumChoice. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

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
}


@end
