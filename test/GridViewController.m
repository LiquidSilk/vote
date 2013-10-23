//
//  GridViewController.m
//  test
//
//  Created by 陈 忠杰 on 13-9-23.
//  Copyright (c) 2013年 陈 忠杰. All rights reserved.
//

#import "GridViewController.h"
#import "CollectionCell.h"
#import "EventManager.h"
#import "MsgModel.h"

@interface GridViewController ()

@end

@implementation GridViewController

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
    
    [[SubscribeModel sharedModel] pushObserver:self];
    
    NSMutableDictionary * __data = [[NSMutableDictionary alloc] init];
    
    _curClassId = [[EventManager sharedEventManager] topId];
    NSString* classId = [NSString stringWithFormat:@"%d", _curClassId];
    [__data setValue:classId forKey:@"topClass"];
    [[MsgModel sharedModel] sendMsg:3002 withData:__data];
    
    bool bShowAddBtn = [[EventManager sharedEventManager] showAddBtn];
    if (!_bSelectClassMode && bShowAddBtn)
    {
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"新建" style:UIBarButtonItemStyleBordered target:self action:@selector(insertNewObject:)];
        self.navigationItem.rightBarButtonItem = addButton;
    }
    self.title = @"分类列表";
}

- (void)insertNewObject:(id)sender
{
    // 取得目标故事板的对象
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    // 获取目标故事板的视图控制
    UITabBarController *nextViewController =[storyboard instantiateViewControllerWithIdentifier:@"EventViewBoard"];
    [self.navigationController pushViewController:nextViewController animated:YES];
    
    [[EventManager sharedEventManager] setClassId:0];
    [[EventManager sharedEventManager] setClassName:@""];
    [[EventManager sharedEventManager] setDesc:@""];
    
    [[EventManager sharedEventManager] resetNewEvent];
    
    NSMutableArray* arrayOption = [[NSMutableArray alloc] init];
    [[EventManager sharedEventManager] setArrayOption:arrayOption];
}

-(void)receiveData:(DataVO *)data
{
    if(data.module == 3002)
    {
        NSNumber* result = [data.data objectForKey:@"result"];
        if([result isEqual:[NSNumber numberWithInt:1]])
        {
            _ClassIdArray = [data.data objectForKey:@"configs"];
            [self.collectionView reloadData];
            //            NSDictionary* pDict = [_ClassIdArray objectAtIndex:1];
            //            NSString* str = [pDict objectForKey:@"cid"];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return [_ClassIdArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    // we're going to use a custom UICollectionViewCell, which will hold an image and its label
    //
    CollectionCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    // load the image for this cell
    NSString *imageToLoad = [NSString stringWithFormat:@"class.png"];
    cell.image.image = [UIImage imageNamed:imageToLoad];
    
    // make the cell's title the actual NSIndexPath value
    NSString* _strTitle = [[_ClassIdArray objectAtIndex:indexPath.row] objectForKey:@"classname"];
    cell.label.text = _strTitle;
    //cell.label.textColor = [UIColor whiteColor];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_bSelectClassMode)
    {
        [self.navigationController popViewControllerAnimated:YES];
        int index = indexPath.row;
        NSDictionary* _dict = [_ClassIdArray objectAtIndex:index];
        int _id = [[_dict objectForKey:@"cid"] intValue];
        [[EventManager sharedEventManager] setClassId:_id];
        
        NSString* _strTitle = [[_ClassIdArray objectAtIndex:indexPath.row] objectForKey:@"classname"];
        [[EventManager sharedEventManager] setClassName:_strTitle];
    }
    else
    {
        int index = indexPath.row;
        NSDictionary* _dict = [_ClassIdArray objectAtIndex:index];
        int _id = [[_dict objectForKey:@"cid"] intValue];
        [[EventManager sharedEventManager] setClassId:_id];
        
        // 取得目标故事板的对象
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
        // 获取目标故事板的视图控制
        UITabBarController *nextViewController =[storyboard instantiateViewControllerWithIdentifier:@"MainList"];
        [self.navigationController pushViewController:nextViewController animated:YES];
    }
}

#pragma mark -
-(void)setClassId:(int)classId
{
    _curClassId = classId;
}
-(void)setSelectClassMode:(bool)enable
{
    _bSelectClassMode = enable;
}
@end
