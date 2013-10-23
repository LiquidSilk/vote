//
//  ClassSelectViewController.h
//  test
//
//  Created by 陈 忠杰 on 13-9-23.
//  Copyright (c) 2013年 陈 忠杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassSelectViewController : UIViewController
{
    NSArray* _ClassIdArray;
    int nRowSelect;
}
@property (strong, nonatomic) IBOutlet UIPickerView *selectPicker;

@end
