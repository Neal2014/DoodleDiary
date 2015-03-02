//
//  WifiViewController.h
//  SettingsExample
//
//  Created by Jake Marsh on 10/9/11.
//  Copyright (c) 2011 Rubber Duck Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMStaticContentTableViewController.h"
#import "PAPasscodeViewController.h"

@interface WifiViewController : JMStaticContentTableViewController<PAPasscodeViewControllerDelegate>
//显示密码
@property(nonatomic,retain)UILabel *passwordLabel;
@property (assign) BOOL simple;
@end
