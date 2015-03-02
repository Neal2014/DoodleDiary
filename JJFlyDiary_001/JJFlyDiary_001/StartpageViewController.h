//
//  StartpageViewController.h
//  PassWord1
//
//  Created by 雷江 on 14-11-12.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JJFlyDiaryViewController;
@class DoodleDiaryViewController;
@interface StartpageViewController : UIViewController
{
    
//    UIImageView *zView;//Z图片ImageView
    UIImageView *fView;//F图片ImageView
    
    
    UIView *rView;//图片的UIView
    UINavigationController *nav;
    JJFlyDiaryViewController *rootVC;
}


@property(nonatomic,retain) UINavigationController *nav;
@property(nonatomic,retain) JJFlyDiaryViewController *rootVC;

@end
