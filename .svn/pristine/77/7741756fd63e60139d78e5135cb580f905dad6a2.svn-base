//
//  OptionViewController.m
//  test
//
//  Created by 陈 忠杰 on 13-9-16.
//  Copyright (c) 2013年 陈 忠杰. All rights reserved.
//

#import "OptionViewController.h"
#import "MsgModel.h"
#import "EventManager.h"
#import "TableViewCommonCell.h"
#import "InputOptionNameViewController.h"

@interface OptionViewController ()

@end

@implementation OptionViewController

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
    
    //addButton
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addOption:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    [[SubscribeModel sharedModel] pushObserver:self];
    self.newOption = [[OptionVO alloc] init];
    
    //init
    NSMutableArray* _arrayOption = [[EventManager sharedEventManager] arrayOption];
    for (int i = 0; i < _arrayOption.count; i++)
    {
        OptionVO* VO = [_arrayOption objectAtIndex:i];
        if ([VO.optionId isEqualToString:@""])
        {
            [_arrayOption removeObjectAtIndex:i];
        }
    }
    NSLog(@"%@",_arrayOption);
    if (!_arrayOption || [_arrayOption count] == 0)
    {       
        __objects = [[NSMutableArray alloc] init];
        
        self.newOption.optionId = @"";
        self.newOption.title = @"";//[arrayEvent objectAtIndex:0];
        self.newOption.optionValue = @"";
        self.newOption.isOpen = YES;
        [__objects addObject:self.newOption];
        _addMode = NO;
    }
    else
    {
        __objects = _arrayOption;
        [self.newOption release];
        self.newOption = nil;
        _addMode = YES;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.optionTableView reloadData];
}

-(void)receiveData:(DataVO *)data
{
    if(data.module == 2007)
    {
        NSNumber* result = [data.data objectForKey:@"result"];
        if([result isEqual:[NSNumber numberWithInt:1]])
        {
            _addMode = YES;
            if (!self.newOption)
            {
                self.newOption = [[OptionVO alloc] init];
            }
            
            OptionVO* tempNewOption = [[OptionVO alloc] init];
            NSMutableArray* arrayOption = [[EventManager sharedEventManager] arrayOption];
            tempNewOption.optionId = [[data.data objectForKey:@"newOption"] objectForKey:@"_id"];
            tempNewOption.title = [[data.data objectForKey:@"newOption"] objectForKey:@"sTitle"];
            tempNewOption.optionValue = [[data.data objectForKey:@"newOption"] objectForKey:@"optionValue"];
            tempNewOption.isOpen = [[data.data objectForKey:@"newOption"] objectForKey:@"isOpen"];
            
            bool exist = NO;
            for (int i = 0; i < arrayOption.count; i++)
            {
                id VO1 = [arrayOption objectAtIndex:i];
                if (!VO1)
                {
                    [arrayOption removeObjectAtIndex:i];
                }
                OptionVO* VO = [arrayOption objectAtIndex:i];
                if ([VO.optionId isEqualToString:tempNewOption.optionId])
                {
                    exist = YES;
                }
            }
            if (!exist)
            {
                //[arrayOption addObject:self.newOption];
                [arrayOption insertObject:tempNewOption atIndex:0];
            }
//            [__objects removeObject:self.newOption];
//            [self.newOption release];
//            self.newOption = nil;
//            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"" message:@"选项添加成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
//            // optional - add more buttons:
//            [alert show];
        }
    }
}

-(void)addOption:(id)sender
{
    if (_addMode)
    {
        if (!__objects) {
            __objects = [[NSMutableArray alloc] init];
        }
        [self.optionTableView beginUpdates];
        self.newOption = [[OptionVO alloc] init];
        self.newOption.title = @"";//[arrayEvent objectAtIndex:0];
        self.newOption.optionId = @"";
        self.newOption.optionValue = @"";
        self.newOption.isOpen = YES;
        [__objects insertObject:self.newOption atIndex:0];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        NSArray* pArray = [NSArray arrayWithObject:indexPath];
        [self.optionTableView insertRowsAtIndexPaths:pArray withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.optionTableView insertSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationTop];
        [self.optionTableView endUpdates];
        _addMode = NO;
    }
    else
    {
        if ([self.newOption.title isEqualToString:@""])
        {
            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"" message:@"请输入选项名称" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
            // optional - add more buttons:
            [alert show];
            return;
        }
        
        NSString* optionValue = self.newOption.optionValue;
        if (!optionValue || [optionValue isEqual:[NSNull null]] || [optionValue isEqualToString:@""])
        {
            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"" message:@"请输入选项描述" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
            // optional - add more buttons:
            [alert show];
            return;
        }
        NSMutableArray* arrayOption2 = [[EventManager sharedEventManager] arrayOption];
        NSMutableDictionary * __data = [[NSMutableDictionary alloc] init];
        NSString* strId = [[EventManager sharedEventManager] eventId];
        
        int isOpen = self.newOption.isOpen ? 1 : 0;
        [__data setValue:self.newOption.title forKey:@"sTitle"];
        [__data setValue:strId forKey:@"event"];
        [__data setValue:self.newOption.optionValue forKey:@"optionValue"];
        [__data setValue:[NSString stringWithFormat:@"%d",isOpen] forKey:@"isOpen"];
        [[MsgModel sharedModel] sendMsg:2007 withData:__data];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [__objects count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* arrayEvent = [_titleDic objectForKey:@"Option"];
    TableViewCommonCell *cell;
    OptionVO* vo = [__objects objectAtIndex:indexPath.section];
    if (indexPath.row == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell0" forIndexPath:indexPath];
        NSString* title = [arrayEvent objectAtIndex:0];
        cell.label1.text = [NSString stringWithFormat:@"%@%d", title, __objects.count - indexPath.section];
        
        UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectMake(210, 10.0f, 100.0f, 30)];
        switchView.tag = __objects.count - indexPath.section;
        switchView.on = vo.isOpen;
        [switchView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [cell.contentView addSubview:switchView];
    }
    else if (indexPath.row == 1)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell1" forIndexPath:indexPath];
        cell.label2.text = vo ? vo.optionValue : @"";
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell2" forIndexPath:indexPath];
        NSString* title = [arrayEvent objectAtIndex:1];
        cell.label1.text = [NSString stringWithFormat:@"%@", title];
        cell.label2.text = vo ? vo.title : @"";
    }
    
    // 自定义文本信息1
//    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
//    NSString* title1 = [arrayEvent objectAtIndex:0];
//    label1.text = [NSString stringWithFormat:@"%@%d", title1, indexPath.section + 1];
//    label1.backgroundColor = [UIColor clearColor];
//    label1.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:18];
//    [cell.contentView addSubview:label1];
    
//    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, 100, 20)];
//    NSString* title2 = [arrayEvent objectAtIndex:1];
//    label2.text = title2;
//    label2.backgroundColor = [UIColor clearColor];
//    label2.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:18];
//    [cell.contentView addSubview:label2];
//    
//    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 160, 30)];
//    int index = indexPath.section;
//    OptionVO* vo = [__objects objectAtIndex:index];
//    if (vo)
//    {
//        textField.text = vo.title;
//    }
//    else
//    {
//        textField.text = [arrayEvent objectAtIndex:0];
//    }
//    textField.tag = indexPath.section * 10 + indexPath.row;
//    textField.backgroundColor = [UIColor clearColor];
//    textField.returnKeyType = UIReturnKeyDone;
//    textField.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:18];
//    textField.delegate = self;
//    [cell.contentView addSubview:textField];
//    [textField addTarget:self action:@selector(textFieldWithText:) forControlEvents:UIControlEventEditingChanged];
//    
//    UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectMake(154.0f, 16.0f, 100.0f, 28.0f)];
//    switchView.tag = indexPath.section * 10 + indexPath.row;
//    [switchView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    
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
    if (indexPath.section != 0)
    {
        return;
    }
    if (indexPath.row == 1 || indexPath.row == 2)
    {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
        InputOptionNameViewController *nextViewController =[storyboard instantiateViewControllerWithIdentifier:@"InputOptionName"];
        [nextViewController setInputType:indexPath.row];
        [nextViewController setOptionArray:__objects];
        [nextViewController setOptionView:self];
        [nextViewController setIndexToEdit:indexPath.section];
        [self.navigationController pushViewController:nextViewController animated:YES];
    }
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return NO;
}

#pragma mark - UISwitchDelegate
- (IBAction)switchAction:(id)sender {
    UISwitch *switchButton = (UISwitch*)sender;
    int tag = switchButton.tag;
    int index = __objects.count - tag;
    if (index == 0)
    {
        self.newOption.isOpen = switchButton.isOn;
    }
}

#pragma mark - textField Delegate
- (void)textFieldWithText:(UITextField *)textField
{
    switch (textField.tag) {
        case 0:
            self.newOption.title = textField.text;
            break;
        default:
            break;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
@end
