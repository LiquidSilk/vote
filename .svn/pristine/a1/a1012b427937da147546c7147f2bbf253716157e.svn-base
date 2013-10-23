//
//  InputOptionNameViewController.m
//  test
//
//  Created by 陈 忠杰 on 13-9-26.
//  Copyright (c) 2013年 陈 忠杰. All rights reserved.
//

#import "InputOptionNameViewController.h"
#import "EventManager.h"

@interface InputOptionNameViewController ()

@end

@implementation InputOptionNameViewController

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
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(finishOnSelect:)];
    self.navigationItem.rightBarButtonItem = doneButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InputCell" forIndexPath:indexPath];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

#pragma mark - label
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [textField addTarget:self action:@selector(textFieldWithText:) forControlEvents:UIControlEventEditingChanged];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.strEventName = textField.text;
}

- (void)textFieldWithText:(UITextField *)textField
{
    self.strEventName = textField.text;
}

#pragma mark - callback
-(void)finishOnSelect:(id)sender
{
    if (_inputType == 1)
    {
        OptionVO* optVO = [_optionArray objectAtIndex:_indexToEdit];
        optVO.optionValue = self.strEventName;
    }
    else if(_inputType == 2)
    {
        OptionVO* optVO = [_optionArray objectAtIndex:_indexToEdit];
        optVO.title = self.strEventName;
    }
    [_optionView set_objects:_optionArray];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -

@end
