//
//  SettingViewController.m
//  test
//
//  Created by 陈 忠杰 on 13-9-16.
//  Copyright (c) 2013年 陈 忠杰. All rights reserved.
//

#import "SettingViewController.h"
#import "EventManager.h"
#import "InputDescViewController.h"
#import "TableViewCommonCell.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

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
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(finishOnSelect:)];
    self.navigationItem.rightBarButtonItem = doneButton;
    
    [self.tableView reloadData];
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
    TableViewCommonCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"SettingCell" forIndexPath:indexPath];
    NSArray* arrayEvent = [_titleDic objectForKey:@"Setting"];
    NSString* title = [[arrayEvent objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    //cell.textLabel.text = title;
    [cell.textLabel drawRect:CGRectMake(10, 10, 80, 80)];
    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, -10, 160, 80)];
//    label.tag = indexPath.section * 10 + indexPath.row;
//    label.backgroundColor = [UIColor clearColor];
//    label.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:18];
//    label.text = title;
//    [cell.contentView addSubview:label];
    cell.label1.text = title;
    
    
    if (indexPath.section == 0)
    {
        cell.label2.text = [[EventManager sharedEventManager] desc];
//        // 自定义文本信息1
//        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(90, 10, 160, 80)];
//        label1.tag = indexPath.section * 10 + indexPath.row;
//        label1.backgroundColor = [UIColor clearColor];
//        label1.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:18];
//        cell.text = [[EventManager sharedEventManager] desc];
//        [cell.contentView addSubview:label1];
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0)
    {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
        InputDescViewController *nextViewController =[storyboard instantiateViewControllerWithIdentifier:@"InputDesc"];
        [self.navigationController pushViewController:nextViewController animated:YES];
    }
    
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

#pragma mark - textField Delegate
- (void)textViewDidChange:(UITextView *)textView
{
    self.desc = textView.text;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [[EventManager sharedEventManager] setDesc:self.desc];
        [self.navigationController popViewControllerAnimated:YES];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
}

#pragma mark - callback
-(void)finishOnSelect:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
