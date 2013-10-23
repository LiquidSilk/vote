//
//  MasterViewController.m
//  test
//
//  Created by 陈 忠杰 on 13-9-16.
//  Copyright (c) 2013年 陈 忠杰. All rights reserved.
//

#import "MasterViewController.h"
#import "EventViewController.h"
#import "DetailViewController.h"
#import "EventManager.h"
#import "MsgModel.h"
#import "ConfigUtil.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        //self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    self.title = @"事件列表";
    bool bShowAddBtn = [[EventManager sharedEventManager] showAddBtn];
    if (bShowAddBtn) {
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"新建" style:UIBarButtonItemStyleBordered target:self action:@selector(insertNewObject:)];
        self.navigationItem.rightBarButtonItem = addButton;
        self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    }
    
    [[SubscribeModel sharedModel] pushObserver:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSMutableDictionary * __data = [[NSMutableDictionary alloc] init];
    int _id = [[EventManager sharedEventManager] classId];
    NSString* classId = [NSString stringWithFormat:@"%d", _id];
    [__data setValue:classId forKey:@"classId"];
    
    [[MsgModel sharedModel] sendMsg:2002 withData:__data];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
//    if (!_objects) {
//        _objects = [[NSMutableArray alloc] init];
//    }
//    [_objects insertObject:[NSDate date] atIndex:0];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    // 取得目标故事板的对象
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    // 获取目标故事板的视图控制
    UITabBarController *nextViewController =[storyboard instantiateViewControllerWithIdentifier:@"EventViewBoard"];
    [self.navigationController pushViewController:nextViewController animated:YES];
    
    [[EventManager sharedEventManager] resetNewEvent];
}

-(void)receiveData:(DataVO *)data
{
    if(data.module == 2002)
    {
        NSNumber* result = [data.data objectForKey:@"result"];
        if([result isEqual:[NSNumber numberWithInt:1]])
        {
            _eventArray = [data.data objectForKey:@"events"];
            [self.tableView reloadData];
        }
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _eventArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDictionary* _dict = [_eventArray objectAtIndex:indexPath.row];
    NSString* title = [_dict objectForKey:@"sTitle"];
    if(![title isEqual:[NSNull null]])
    {
        cell.textLabel.text = title;
    }
    else
    {
        cell.textLabel.text = @"";
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
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* _dict = [_eventArray objectAtIndex:indexPath.row];
    NSString* _id = [_dict objectForKey:@"_id"];
    [[EventManager sharedEventManager] setEventDetailId:_id];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}
@end
