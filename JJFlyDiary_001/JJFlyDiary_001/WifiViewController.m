//
//  WifiViewController.m
//  SettingsExample
//
//  Created by Jake Marsh on 10/9/11.
//  Copyright (c) 2011 Rubber Duck Software. All rights reserved.
//

#import "WifiViewController.h"
#import "PAPasscodeViewController.h"
#import "DXAlertView.h"

@interface WifiViewController ()

@property (nonatomic, strong) UISwitch *wifiSwitch;
@property (nonatomic, strong) UISwitch *askToJoinSwitch;
@property (nonatomic, strong) UIActivityIndicatorView *searchingForNetworksActivityIndicator;

@property (nonatomic, strong) NSArray *simulatedNetworks;
@property (nonatomic, strong) NSIndexPath *selectedNetworkIndexPath;

@property (nonatomic, retain) UISwitch *airplaneModeSwitch;

- (void) _foundNetworks;
//改变开关
- (void) _switchChanged:(UISwitch *)senderSwitch;

@end

@implementation WifiViewController

//开关
@synthesize wifiSwitch = _wifiSwitch;
@synthesize airplaneModeSwitch = _airplaneModeSwitch;

@synthesize askToJoinSwitch = _askToJoinSwitch;
@synthesize searchingForNetworksActivityIndicator = _searchingForNetworksActivityIndicator;

@synthesize simulatedNetworks = _simulatedNetworks;
@synthesize selectedNetworkIndexPath = _selectedNetworkIndexPath;

- (id) init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (!self) return nil;

    //标题
	self.title = NSLocalizedString(@"密码设置", @"密码设置");
//    _wifiSwitch.on=YES;
    
	return self;
}
- (void) _switchChanged:(UISwitch *)senderSwitch {
    
    
	if([senderSwitch isEqual:self.wifiSwitch]) {
		[self.tableView beginUpdates];

		if(self.wifiSwitch.on) {
			[self.tableView insertSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, 2)] withRowAnimation:UITableViewRowAnimationAutomatic];
            NSLog(@"打开");
		} else {
            if ([[NSUserDefaults standardUserDefaults] stringForKey:@"name"]!=nil)
            {
                [self VerifyPassword];
                NSLog(@"清除");
            }
			[self.tableView deleteSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, 2)] withRowAnimation:UITableViewRowAnimationAutomatic];
            NSLog(@"关闭");
		}
		[self.tableView endUpdates];
	}
}

#pragma mark - View lifecycle.
- (void) viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor=[UIColor redColor];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(didClickBackButtonItemAction:)];
    self.wifiSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"name"]!=nil)
    {
        //按钮默认为关闭
        self.wifiSwitch.on = YES;
        
    }else
    {
        self.wifiSwitch.on = NO;
    }
    [self.wifiSwitch addTarget:self action:@selector(_switchChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSection:^(JMStaticContentTableViewSection *section, NSUInteger sectionIndex) {
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = @"UIControlCell";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.textLabel.text = NSLocalizedString(@"密码设置", @"密码设置");
            cell.accessoryView = self.wifiSwitch;
        }];
    }];
    [self addSection:^(JMStaticContentTableViewSection *section, NSUInteger sectionIndex) {

        
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.cellStyle = UITableViewCellStyleValue1;
            cell.textLabel.text = NSLocalizedString(@"设置密码", @"设置密码");
        } whenSelected:^(NSIndexPath *indexPath) {
            
            if ([[NSUserDefaults standardUserDefaults] stringForKey:@"name"]!=nil)
            {
                
                DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"当前已有密码！需要重新设置吗？" leftButtonTitle:@"确定" rightButtonTitle:@"取消"];
                [alert show];
                alert.leftBlock = ^() {
                    [self showPinViewAnimated:YES];
                    NSLog(@"left button clicked");
                };
                alert.rightBlock = ^() {
                    NSLog(@"right button clicked");
                };
            }else
            {
                [self showPinViewAnimated:YES];
            }
            
        }];
    }];
    
    [self addSection:^(JMStaticContentTableViewSection *section, NSUInteger sectionIndex) {
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.cellStyle = UITableViewCellStyleValue1;
            staticContentCell.reuseIdentifier = @"DetailTextCell";
            
            cell.textLabel.text = NSLocalizedString(@"修改密码", @"修改密码");
        } whenSelected:^(NSIndexPath *indexPath) {
            //跳转页面
            if ([[NSUserDefaults standardUserDefaults] stringForKey:@"name"]!=nil)
            {
                [self ShouModification:YES];
            }else
            {
                DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"请设置密码！" leftButtonTitle:@"确定" rightButtonTitle:@"取消"];
                [alert show];
                alert.leftBlock = ^() {
                    NSLog(@"left button clicked");
                };
                alert.rightBlock = ^() {
                    NSLog(@"right button clicked");
                };
            }
        }];
    }];
}
//返回
- (void)didClickBackButtonItemAction:(UIBarButtonItem *)buttonItem
{
    [self.navigationController popViewControllerAnimated:YES];
}
//验证密码
-(void)VerifyPassword
{
    PAPasscodeViewController *passcodeViewController = [[PAPasscodeViewController alloc] initForAction:PasscodeActionEnter];
    passcodeViewController.delegate = self;
    passcodeViewController.passcode = [[NSUserDefaults standardUserDefaults] stringForKey:@"name"];
    [self presentViewController:passcodeViewController animated:YES completion:nil];
     [self RemoveThePassword];
    NSLog(@"验证成功！清除密码");
}
//清除密码
-(void)RemoveThePassword
{
    //删除密码。删除整个plist文件
    NSUserDefaults *userDefatluts = [NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary = [userDefatluts dictionaryRepresentation];
    for(NSString* key in [dictionary allKeys]){
        [userDefatluts removeObjectForKey:key];
        [userDefatluts synchronize];
    }
}
//数字密码，修改
-(void)ShouModification:(BOOL)animated
{
    PAPasscodeViewController *passcodeViewController = [[PAPasscodeViewController alloc] initForAction:PasscodeActionChange];
    passcodeViewController.delegate = self;
    passcodeViewController.passcode = [[NSUserDefaults standardUserDefaults] stringForKey:@"name"];
    [self presentViewController:passcodeViewController animated:YES completion:nil];
}

//数字密码，设置
- (void)showPinViewAnimated:(BOOL)animated
{
    PAPasscodeViewController *passcodeViewController=[[PAPasscodeViewController alloc] initForAction:PasscodeActionSet];
    passcodeViewController.delegate=self;
    [self presentViewController:passcodeViewController animated:YES completion:nil];
    
}
- (void) viewDidUnload {
    [super viewDidUnload];

	self.wifiSwitch = nil;
	self.askToJoinSwitch = nil;
	self.searchingForNetworksActivityIndicator = nil;
}
#pragma mark - Table View Delegate

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	if(section == 1) {
		UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 16.0)];

		UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 10.0, 320.0, 16.0)];
		headerLabel.font = [UIFont boldSystemFontOfSize:16.0];
		headerLabel.textColor = [UIColor colorWithRed:61.0/255.0 green:77.0/255.0 blue:99.0/255.0 alpha:1.0];
		headerLabel.shadowColor = [UIColor colorWithWhite:1.0 alpha:0.65];
		headerLabel.shadowOffset = CGSizeMake(0.0, 1.0);

		[header addSubview:headerLabel];

		self.searchingForNetworksActivityIndicator.frame = CGRectMake(190.0, 18.0, 0.0, 0.0);
		[header addSubview:self.searchingForNetworksActivityIndicator];

		return header;
	} else {
		return nil;
	}
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
		return UITableViewAutomaticDimension;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
	if(self.wifiSwitch.on) {
		return [super numberOfSectionsInTableView:tableView];
	} else {
		return 1;
	}
}

- (void)PAPasscodeViewControllerDidCancel:(PAPasscodeViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)PAPasscodeViewControllerDidEnterPasscode:(PAPasscodeViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:^() {
//        [[[UIAlertView alloc] initWithTitle:nil message:@"Passcode entered correctly" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];
}

- (void)PAPasscodeViewControllerDidSetPasscode:(PAPasscodeViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:^() {

//        _passwordLabel.text = controller.passcode;
    }];
    //    WifiViewController *wi=[[WifiViewController alloc] init];
    //    [self.navigationController popToViewController:wi animated:YES];
}

- (void)PAPasscodeViewControllerDidChangePasscode:(PAPasscodeViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:^() {
//        _passwordLabel.text = controller.passcode;
    }];
}

@end