//
//  VoteObjectOptionViewController.m
//  test
//
//  Created by 陈 忠杰 on 13-9-24.
//  Copyright (c) 2013年 陈 忠杰. All rights reserved.
//

#import "VoteObjectOptionViewController.h"
#import "InputDescViewController.h"
#import "TableViewCommonCell.h"
#import "ObjectTypeViewController.h"
#import "EventManager.h"

@interface VoteObjectOptionViewController ()

@end

@implementation VoteObjectOptionViewController

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
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"WordList" ofType:@"plist"];
    _titleDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleBordered target:self action:@selector(saveOnSelect:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    self.title = @"投票对象设置";
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* array = [_titleDic objectForKey:@"VoteObjectOption"];
    TableViewCommonCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        NSString* desc = [[EventManager sharedEventManager] desc];
        cell.label2.text = desc;
    }
    else if(indexPath.section == 1 && indexPath.row == 0)
    {
        NSString* type = [[EventManager sharedEventManager] objectType];
        cell.label2.text = type;
    }
    
    
    NSString* title = [[array objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.label1.text = title;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
        InputDescViewController *nextViewController =[storyboard instantiateViewControllerWithIdentifier:@"InputDesc"];
        [self.navigationController pushViewController:nextViewController animated:YES];
    }
    if (indexPath.section == 1 && indexPath.row == 0)
    {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
        ObjectTypeViewController *nextViewController =[storyboard instantiateViewControllerWithIdentifier:@"ObjectType"];
        [self.navigationController pushViewController:nextViewController animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - callback
-(void)saveOnSelect:(id)sender
{
//    NSString* strEventName = [[EventManager sharedEventManager] eventName];
//    if (!strEventName || [strEventName isEqualToString:@""])
//    {
//        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"" message:@"请输入事件名称" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
//        // optional - add more buttons:
//        [alert show];
//    }
//    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
