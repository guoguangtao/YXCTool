//
//  BroadcastSetupViewController.m
//  ReplayUIExtension
//
//  Created by lbkj on 2021/12/3.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "BroadcastSetupViewController.h"

@implementation BroadcastSetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [UILabel new];
    label.text = @"录制屏幕";
    label.textColor = UIColor.orangeColor;
    label.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:label];
    CGSize size = [label sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    label.frame = CGRectMake(10, 100, size.width, size.height);
}

// Call this method when the user has finished interacting with the view controller and a broadcast stream can start
- (void)userDidFinishSetup {
    
    // URL of the resource where broadcast can be viewed that will be returned to the application
    NSURL *broadcastURL = [NSURL URLWithString:@"http://apple.com/broadcast/streamID"];
    
    // Dictionary with setup information that will be provided to broadcast extension when broadcast is started
    NSDictionary *setupInfo = @{ @"broadcastName" : @"example" };
    
    // Tell ReplayKit that the extension is finished setting up and can begin broadcasting
    [self.extensionContext completeRequestWithBroadcastURL:broadcastURL setupInfo:setupInfo];
}

- (void)userDidCancelSetup {
    // Tell ReplayKit that the extension was cancelled by the user
    [self.extensionContext cancelRequestWithError:[NSError errorWithDomain:@"YourAppDomain" code:-1 userInfo:nil]];
}

@end
