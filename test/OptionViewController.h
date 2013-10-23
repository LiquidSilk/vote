//
//  OptionViewController.h
//  test
//
//  Created by 陈 忠杰 on 13-9-16.
//  Copyright (c) 2013年 陈 忠杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OptionVO.h"


@interface OptionViewController : UIViewController<UITextViewDelegate>
{
    NSMutableDictionary *_titleDic;
}
@property (strong, nonatomic) IBOutlet UITableView *optionTableView;
@property (nonatomic) OptionVO* newOption;
@property (nonatomic,retain) NSMutableArray *_objects;
@property (nonatomic,assign)bool addMode;
@end


