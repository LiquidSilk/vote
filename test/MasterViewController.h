//
//  MasterViewController.h
//  test
//
//  Created by 陈 忠杰 on 13-9-16.
//  Copyright (c) 2013年 陈 忠杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UIViewController
{
    NSArray* _eventArray;
}


@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) IBOutlet UITableView* tableView;
@end
