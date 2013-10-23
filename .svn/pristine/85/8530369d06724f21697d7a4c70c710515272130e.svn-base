//
//  ClassSelectViewController.m
//  test
//
//  Created by 陈 忠杰 on 13-9-23.
//  Copyright (c) 2013年 陈 忠杰. All rights reserved.
//

#import "ClassSelectViewController.h"
#import "MsgModel.h"
#import "EventManager.h"

@interface ClassSelectViewController ()

@end

@implementation ClassSelectViewController

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
    
    [[SubscribeModel sharedModel] pushObserver:self];
    
    NSMutableDictionary * __data = [[NSMutableDictionary alloc] init];
    int _curClassId = [[EventManager sharedEventManager] topId];
    NSString* classId = [NSString stringWithFormat:@"%d", _curClassId];
    [__data setValue:classId forKey:@"topClass"];
    [[MsgModel sharedModel] sendMsg:3002 withData:__data];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(finishOnSelect:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    nRowSelect = 0;
}

-(void)receiveData:(DataVO *)data
{
    if(data.module == 3002)
    {
        NSNumber* result = [data.data objectForKey:@"result"];
        if([result isEqual:[NSNumber numberWithInt:1]])
        {
            _ClassIdArray = [data.data objectForKey:@"configs"];
            [self.selectPicker reloadData];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(12.0f, 0.0f, [pickerView rowSizeForComponent:component].width-12, [pickerView rowSizeForComponent:component].height)] autorelease];
    
    [label setText:[[_ClassIdArray objectAtIndex:row] objectForKey:@"classname"]];
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
    return [[_ClassIdArray objectAtIndex:row] objectForKey:@"classname"];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    nRowSelect = row;
}

-(void)finishOnSelect:(id)sender
{
    NSDictionary* _dict = [_ClassIdArray objectAtIndex:nRowSelect];
    int _id = [[_dict objectForKey:@"cid"] intValue];
    [[EventManager sharedEventManager] setClassId:_id];
    
    NSString* _strTitle = [_dict objectForKey:@"classname"];
    [[EventManager sharedEventManager] setClassName:_strTitle];
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
