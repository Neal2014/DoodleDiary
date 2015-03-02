//
//  SettingsViewController.m
//  SettingsExample
//
//  Created by Jake Marsh on 10/8/11.
//  Copyright (c) 2011 Rubber Duck Software. All rights reserved.
//

#import "SettingsViewController.h"
#import "WifiViewController.h"
#import "PAPasscodeViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (id) init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (!self) return nil;

	return self;
}

#pragma mark - View lifecycle

- (void) viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户中心";
    [self addSection:^(JMStaticContentTableViewSection *section, NSUInteger sectionIndex) {
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.cellStyle = UITableViewCellStyleValue1;
            staticContentCell.reuseIdentifier = @"UIControlCell";
            
            cell.textLabel.text = NSLocalizedString(@"密码设置", @"密码设置");
        } whenSelected:^(NSIndexPath *indexPath) {
            [self.navigationController pushViewController:[[WifiViewController alloc] init] animated:YES];
        }];
        
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.cellStyle = UITableViewCellStyleValue1;
            staticContentCell.reuseIdentifier = @"UIControlCell";
            
            cell.textLabel.text = NSLocalizedString(@"使用帮助", @"使用帮助");
        } whenSelected:^(NSIndexPath *indexPath) {
            [self.navigationController pushViewController:[[WifiViewController alloc] init] animated:YES];
        }];
        
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.cellStyle = UITableViewCellStyleValue1;
            staticContentCell.reuseIdentifier = @"UIControlCell";
            
            cell.textLabel.text = NSLocalizedString(@"关于软件", @"关于软件");
        } whenSelected:^(NSIndexPath *indexPath) {
            [self.navigationController pushViewController:[[WifiViewController alloc] init] animated:YES];
        }];
        
        
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.cellStyle = UITableViewCellStyleValue1;
            staticContentCell.reuseIdentifier = @"UIControlCell";
            
            cell.textLabel.text = NSLocalizedString(@"我要评分", @"我要评分");
        } whenSelected:^(NSIndexPath *indexPath) {
            [self.navigationController pushViewController:[[WifiViewController alloc] init] animated:YES];
        }];
        
        
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.cellStyle = UITableViewCellStyleValue1;
            staticContentCell.reuseIdentifier = @"UIControlCell";
            
            cell.textLabel.text = NSLocalizedString(@"版本更新", @"版本更新");
        } whenSelected:^(NSIndexPath *indexPath) {
            [self.navigationController pushViewController:[[WifiViewController alloc] init] animated:YES];
        }];
    }];
}
- (void) viewDidUnload {
    [super viewDidUnload];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end