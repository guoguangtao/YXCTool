//
//  AppDelegate.h
//  YXCTools
//
//  Created by GGT on 2020/4/17.
//  Copyright © 2020 GGT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, assign, getter=isLaunchScreen) BOOL launchScreen;    /**< 是否是横屏 */
@property (nonatomic, weak) UINavigationController *navigationController;

@end

