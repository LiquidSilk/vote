//
//  ObjectTypeViewController.m
//  test
//
//  Created by 陈 忠杰 on 13-9-24.
//  Copyright (c) 2013年 陈 忠杰. All rights reserved.
//

#import "ObjectTypeViewController.h"
#import "EventManager.h"

@interface ObjectTypeViewController ()

@end

@implementation ObjectTypeViewController

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
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(finishOnSelect:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"WordList" ofType:@"plist"];
    _titleDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    _ClassIdArray = [_titleDic objectForKey:@"ObjectType"];
    
    nRowSelect = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_pickerView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setPickerView:nil];
    [super viewDidUnload];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(12.0f, 0.0f, [pickerView rowSizeForComponent:component].width-12, [pickerView rowSizeForComponent:component].height)] autorelease];
    
    NSString* str = [_ClassIdArray objectAtIndex:row];
    [label setText:[_ClassIdArray objectAtIndex:row]];
    label.backgroundColor = [UIColor clearColor];
    [label setTextAlignment:UITextAlignmentCenter];
    return label;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _ClassIdArray.count;
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_ClassIdArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    nRowSelect = row;
}

-(void)finishOnSelect:(id)sender
{
    [[EventManager sharedEventManager] setObjectType:[_ClassIdArray objectAtIndex:nRowSelect]];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
