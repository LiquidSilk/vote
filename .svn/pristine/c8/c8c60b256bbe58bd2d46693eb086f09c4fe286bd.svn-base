//
//  DataSelectViewController.m
//  test
//
//  Created by 陈 忠杰 on 13-9-24.
//  Copyright (c) 2013年 陈 忠杰. All rights reserved.
//

#import "DataSelectViewController.h"
#import "EventManager.h"

@interface DataSelectViewController ()

@end

@implementation DataSelectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(saveOnSelect:)];
    self.navigationItem.rightBarButtonItem = doneButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_dataPicker release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setDataPicker:nil];
    [super viewDidUnload];
}

#pragma mark - callback
-(void)saveOnSelect:(id)sender
{
    NSDate* date = self.dataPicker.date;
    [[EventManager sharedEventManager] setOutRangeDate:date];
    [self.navigationController popViewControllerAnimated:YES];
    
//    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
//    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSString* string=[dateFormat stringFromDate:date];
//    
//    long long time = (long long)[date timeIntervalSince1970];
//    NSLog(@"%lld", time);
//    
//    
//    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time];
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate:confromTimesp];
//    NSDate *localeDate = [confromTimesp dateByAddingTimeInterval: interval];
//    NSLog(@"=== %@",localeDate);
}
@end
