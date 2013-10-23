//
//  GridViewController.h
//  test
//
//  Created by 陈 忠杰 on 13-9-23.
//  Copyright (c) 2013年 陈 忠杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridViewController : UIViewController
{
    int _curClassId;
    bool _bSelectClassMode;
    NSArray* _ClassIdArray;
}
@property(strong, nonatomic)IBOutlet UICollectionView* collectionView;
-(void)setClassId:(int)classId;
-(void)setSelectClassMode:(bool)enable;
@end
