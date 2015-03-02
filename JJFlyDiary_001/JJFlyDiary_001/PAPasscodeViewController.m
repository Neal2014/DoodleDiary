//
//  PAPasscodeViewController.m
//  PAPasscode
//
//  Created by Denis Hennessy on 15/10/2012.
//  Copyright (c) 2012 Peer Assembly. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "PAPasscodeViewController.h"

#define NAVBAR_HEIGHT   44
#define PROMPT_HEIGHT   74
#define DIGIT_SPACING   10
#define DIGIT_WIDTH     61
#define DIGIT_HEIGHT    53
#define MARKER_WIDTH    16
#define MARKER_HEIGHT   16
#define MARKER_X        22
#define MARKER_Y        18
#define MESSAGE_HEIGHT  74
#define FAILED_LCAP     19
#define FAILED_RCAP     19
#define FAILED_HEIGHT   26
#define FAILED_MARGIN   10
#define TEXTFIELD_MARGIN 8
#define SLIDE_DURATION  0.3

@interface PAPasscodeViewController ()
- (void)cancel:(id)sender;
- (void)handleFailedAttempt;
- (void)handleCompleteField;
- (void)passcodeChanged:(id)sender;
- (void)resetFailedAttempts;
- (void)showFailedAttempts;
- (void)showScreenForPhase:(NSInteger)phase animated:(BOOL)animated;
@end

@implementation PAPasscodeViewController

- (id)initForAction:(PasscodeAction)action {
    self = [super init];
    if (self) {

        _action = action;
        switch (action) {
            case PasscodeActionSet:
                self.title = NSLocalizedString(@"设置密码", nil);
                _enterPrompt = NSLocalizedString(@"请输入您的密码", nil);
                _confirmPrompt = NSLocalizedString(@"请再输入您的密码", nil);
                break;
                
            case PasscodeActionEnter:
                self.title = NSLocalizedString(@"验证密码", nil);
                
                _enterPrompt = NSLocalizedString(@"请输入您的密码", nil);
                break;
                
            case PasscodeActionChange:
                self.title = NSLocalizedString(@"修改密码", nil);
                _changePrompt = NSLocalizedString(@"请输入旧密码", nil);
                _enterPrompt = NSLocalizedString(@"请输入新密码", nil);
                _confirmPrompt = NSLocalizedString(@"请再次输入新密码", nil);
                break;
        }
        self.modalPresentationStyle = UIModalPresentationFormSheet;
        _simple = YES;
    }
    return self;
}
- (void)loadView {
    
    
    _views = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    
    _views.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, _views.bounds.size.width, NAVBAR_HEIGHT)];
    navigationBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    //背景
    navigationBar.items = @[self.navigationItem];
    [_views addSubview:navigationBar];
    
    
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, _views.bounds.size.width, _views.bounds.size.height-NAVBAR_HEIGHT)];
    contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    UIImage *image=[UIImage imageNamed:@"26.jpg"];
    contentView.layer.contents=(id)image.CGImage;


    [_views addSubview:contentView];
    
    CGFloat panelWidth = DIGIT_WIDTH*4+DIGIT_SPACING*3;

    UIView *digitPanel = [[UIView alloc] initWithFrame:CGRectMake(0, 0, panelWidth, DIGIT_HEIGHT)];
    digitPanel.frame = CGRectOffset(digitPanel.frame, (contentView.bounds.size.width-digitPanel.bounds.size.width)/2, PROMPT_HEIGHT);
    digitPanel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
    [contentView addSubview:digitPanel];
    
    UIImage *backgroundImage = [UIImage imageNamed:@"sns_writeD_weather-2"];
    UIImage *markerImage = [UIImage imageNamed:@"papasscode_marker"];
    CGFloat xLeft = 0;
    for (int i=0;i<4;i++) {
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
        backgroundImageView.frame = CGRectOffset(backgroundImageView.frame, xLeft, 0);
        [digitPanel addSubview:backgroundImageView];
        digitImageViews[i] = [[UIImageView alloc] initWithImage:markerImage];
        digitImageViews[i].autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        digitImageViews[i].frame = CGRectOffset(digitImageViews[i].frame, backgroundImageView.frame.origin.x+MARKER_X, MARKER_Y);
        [digitPanel addSubview:digitImageViews[i]];
        xLeft += DIGIT_SPACING + backgroundImage.size.width;
    }
    passcodeTextField = [[UITextField alloc] initWithFrame:digitPanel.frame];
    passcodeTextField.hidden = YES;

    passcodeTextField.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
    passcodeTextField.borderStyle = UITextBorderStyleNone;
    passcodeTextField.secureTextEntry = YES;
    passcodeTextField.textColor = [UIColor colorWithRed:0.23 green:0.33 blue:0.52 alpha:1.0];
    passcodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    [passcodeTextField addTarget:self action:@selector(passcodeChanged:) forControlEvents:UIControlEventEditingChanged];
    [contentView addSubview:passcodeTextField];

    promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, contentView.bounds.size.width, PROMPT_HEIGHT)];
    promptLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    promptLabel.backgroundColor = [UIColor clearColor];
    promptLabel.textColor = [UIColor colorWithRed:0.30 green:0.34 blue:0.42 alpha:1.0];
    promptLabel.font = [UIFont boldSystemFontOfSize:17];
    promptLabel.shadowColor = [UIColor whiteColor];
    promptLabel.shadowOffset = CGSizeMake(0, 1);
    promptLabel.textAlignment = UITextAlignmentCenter;
    promptLabel.numberOfLines = 0;
    [contentView addSubview:promptLabel];
    
    messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, PROMPT_HEIGHT+DIGIT_HEIGHT, contentView.bounds.size.width, MESSAGE_HEIGHT)];
    messageLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    messageLabel.backgroundColor = [UIColor clearColor];
    messageLabel.textColor = [UIColor colorWithRed:0.30 green:0.34 blue:0.42 alpha:1.0];
    messageLabel.font = [UIFont systemFontOfSize:14];
    messageLabel.shadowColor = [UIColor whiteColor];
    messageLabel.shadowOffset = CGSizeMake(0, 1);
    messageLabel.textAlignment = UITextAlignmentCenter;
    messageLabel.numberOfLines = 0;
	messageLabel.text = _message;
    [contentView addSubview:messageLabel];
    
    UIImage *failedBg = [[UIImage imageNamed:@"papasscode_failed_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, FAILED_LCAP, 0, FAILED_RCAP)];
    failedImageView = [[UIImageView alloc] initWithImage:failedBg];
    failedImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
    failedImageView.hidden = YES;
    [contentView addSubview:failedImageView];
    
    failedAttemptsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    failedAttemptsLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
    failedAttemptsLabel.backgroundColor = [UIColor clearColor];
    failedAttemptsLabel.textColor = [UIColor whiteColor];
    failedAttemptsLabel.font = [UIFont boldSystemFontOfSize:15];
    failedAttemptsLabel.shadowColor = [UIColor blackColor];
    failedAttemptsLabel.shadowOffset = CGSizeMake(0, -1);
    failedAttemptsLabel.textAlignment = UITextAlignmentCenter;
    failedAttemptsLabel.hidden = YES;
    [contentView addSubview:failedAttemptsLabel];
    
    self.view = _views;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor colorWithRed:0.365 green:1.000 blue:0.835 alpha:1.000];
//    if (_simple) {
        if (![self.title isEqualToString:@"验证密码"]) {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel:)];
        }
//    } else {
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
//    }
    if (_failedAttempts > 0) {
        [self showFailedAttempts];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self showScreenForPhase:0 animated:NO];
    [passcodeTextField becomeFirstResponder];
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait|UIInterfaceOrientationMaskPortraitUpsideDown;
}

- (void)cancel:(id)sender {
    [_delegate PAPasscodeViewControllerDidCancel:self];
}

#pragma mark - implementation helpers

- (void)handleCompleteField {
    NSString *text = passcodeTextField.text;
    switch (_action) {
        case PasscodeActionSet:
            if (phase == 0) {
                _passcode = text;
                
                [[NSUserDefaults standardUserDefaults] setObject:_passcode forKey:@"name"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                NSLog(@"%@",_passcode);
                
                
                messageLabel.text = @"";
                [self showScreenForPhase:1 animated:YES];
            } else {
                if ([text isEqualToString:_passcode]) {
                    if ([_delegate respondsToSelector:@selector(PAPasscodeViewControllerDidSetPasscode:)]) {
                        [_delegate PAPasscodeViewControllerDidSetPasscode:self];
                    }
                } else {
                    [self showScreenForPhase:0 animated:YES];
                    messageLabel.text = NSLocalizedString(@"密码不匹配，请重新输入", nil);
                }
            }
            break;
            
        case PasscodeActionEnter:
            
            if ([text isEqualToString:_passcode]) {


                [self resetFailedAttempts];
                if ([_delegate respondsToSelector:@selector(PAPasscodeViewControllerDidEnterPasscode:)]) {
                    [_delegate PAPasscodeViewControllerDidEnterPasscode:self];
                }
            } else {
                [self handleFailedAttempt];
                [self showScreenForPhase:0 animated:NO];
            }
            break;
            
        case PasscodeActionChange:
            if (phase == 0) {
                if ([text isEqualToString:_passcode]) {
                    [self resetFailedAttempts];
                    [self showScreenForPhase:1 animated:YES];
                } else {
                    [self handleFailedAttempt];
                    [self showScreenForPhase:0 animated:NO];
                }
            } else if (phase == 1) {
                _passcode = text;
                [[NSUserDefaults standardUserDefaults] setObject:_passcode forKey:@"name"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                

                
                messageLabel.text = @"";
                [self showScreenForPhase:2 animated:YES];
            } else {
                if ([text isEqualToString:_passcode]) {
                    if ([_delegate respondsToSelector:@selector(PAPasscodeViewControllerDidChangePasscode:)]) {
                        [_delegate PAPasscodeViewControllerDidChangePasscode:self];
                    }
                } else {
                    [self showScreenForPhase:1 animated:YES];
                    messageLabel.text = NSLocalizedString(@"密码不匹配。再试一次", nil);
                }
            }
            break;
    }
}

- (void)handleFailedAttempt {
    _failedAttempts++;
    [self showFailedAttempts];
    if ([_delegate respondsToSelector:@selector(PAPasscodeViewController:didFailToEnterPasscode:)]) {
        [_delegate PAPasscodeViewController:self didFailToEnterPasscode:_failedAttempts];
    }
}

- (void)resetFailedAttempts {
    messageLabel.hidden = NO;
    failedImageView.hidden = YES;
    failedAttemptsLabel.hidden = YES;
    _failedAttempts = 0;
}

- (void)showFailedAttempts {
    messageLabel.hidden = YES;
    failedImageView.hidden = NO;
    failedAttemptsLabel.hidden = NO;
    if (_failedAttempts == 1) {
        failedAttemptsLabel.text = NSLocalizedString(@"密码不正确，请重新输入", nil);
    } else {
        failedAttemptsLabel.text = [NSString stringWithFormat:NSLocalizedString(@"密码不正确，请重新输入", nil), _failedAttempts];
    }
    [failedAttemptsLabel sizeToFit];
    CGFloat bgWidth = failedAttemptsLabel.bounds.size.width + FAILED_MARGIN*2;
    CGFloat x = floor((contentView.bounds.size.width-bgWidth)/2);
    CGFloat y = PROMPT_HEIGHT+DIGIT_HEIGHT+floor((MESSAGE_HEIGHT-FAILED_HEIGHT)/2);
    failedImageView.frame = CGRectMake(x, y, bgWidth, FAILED_HEIGHT);
    x = failedImageView.frame.origin.x+FAILED_MARGIN;
    y = failedImageView.frame.origin.y+floor((failedImageView.bounds.size.height-failedAttemptsLabel.frame.size.height)/2);
    failedAttemptsLabel.frame = CGRectMake(x, y, failedAttemptsLabel.bounds.size.width, failedAttemptsLabel.bounds.size.height);
}

- (void)passcodeChanged:(id)sender {
    NSString *text = passcodeTextField.text;
    if (_simple) {
        if ([text length] > 4) {
            text = [text substringToIndex:4];
        }
        for (int i=0;i<4;i++) {
            digitImageViews[i].hidden = i >= [text length];
        }
        if ([text length] == 4) {
            [self handleCompleteField];
        }
    } else {
        self.navigationItem.rightBarButtonItem.enabled = [text length] > 0;
    }
}

- (void)showScreenForPhase:(NSInteger)newPhase animated:(BOOL)animated {
    CGFloat dir = (newPhase > phase) ? 1 : -1;
    if (animated) {
        UIGraphicsBeginImageContext(self.view.bounds.size);
        [contentView.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        snapshotImageView = [[UIImageView alloc] initWithImage:snapshot];
        snapshotImageView.frame = CGRectOffset(snapshotImageView.frame, -contentView.frame.size.width*dir, 0);
        [contentView addSubview:snapshotImageView];
    }
    phase = newPhase;
    passcodeTextField.text = @"";
//    if (!_simple) {
//        BOOL finalScreen = _action == PasscodeActionSet && phase == 1;
//        finalScreen |= _action == PasscodeActionEnter && phase == 0;
//        finalScreen |= _action == PasscodeActionChange && phase == 2;
//        if (finalScreen) {
//            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(handleCompleteField)];
//        } else {
//            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Next", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(handleCompleteField)];
//        }
//        self.navigationItem.rightBarButtonItem.enabled = YES;
//    }
    
    switch (_action) {
        case PasscodeActionSet:
            
            if (phase == 0) {
                promptLabel.text = _enterPrompt;
            } else {
                promptLabel.text = _confirmPrompt;
            }
            break;
            
        case PasscodeActionEnter:
            
            promptLabel.text = _enterPrompt;
            break;
            
        case PasscodeActionChange:
            if (phase == 0) {
                promptLabel.text = _changePrompt;
            } else if (phase == 1) {
                promptLabel.text = _enterPrompt;
            } else {
                promptLabel.text = _confirmPrompt;
            }
            break;
    }
    for (int i=0;i<4;i++) {
        digitImageViews[i].hidden = YES;
    }
    if (animated) {
        contentView.frame = CGRectOffset(contentView.frame, contentView.frame.size.width*dir, 0);
        [UIView animateWithDuration:SLIDE_DURATION animations:^() {
            contentView.frame = CGRectOffset(contentView.frame, -contentView.frame.size.width*dir, 0);
        } completion:^(BOOL finished) {
            [snapshotImageView removeFromSuperview];
            snapshotImageView = nil;
        }];
    }
}

@end
