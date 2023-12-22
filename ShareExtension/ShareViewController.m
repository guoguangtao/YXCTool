//
//  ShareViewController.m
//  ShareExtension
//
//  Created by guogt on 2023/9/28.
//  Copyright © 2023 GGT. All rights reserved.
//

#import "ShareViewController.h"
#import "YXCToolHeader.h"

@interface ShareViewController ()

@end

@implementation ShareViewController

- (BOOL)isContentValid {
    // Do validation of contentText and/or NSExtensionContext attachments here
    
    return YES;
}

- (void)p_dealData:(void (^)(NSArray *array))complete {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableArray *urls = [NSMutableArray array];
        NSArray *array = self.extensionContext.inputItems;
        if (array.count) {
            dispatch_group_t group = dispatch_group_create();
            for (int i = 0; i < array.count; i++) {
                NSExtensionItem *extensionItem = array[i];
                if (extensionItem.attachments.count) {
                    for (NSItemProvider *itemProvider in extensionItem.attachments) {
                        dispatch_group_enter(group);
                        [itemProvider loadItemForTypeIdentifier:itemProvider.registeredTypeIdentifiers.firstObject
                                                        options:nil
                                              completionHandler:^(__kindof id<NSSecureCoding>  _Nullable item, NSError * _Null_unspecified error) {
                            if (error == nil && item) {
                                NSURL *url = (NSURL *)item;
                                if ([url isKindOfClass:[NSURL class]]) {
                                    [urls addObject:url];
                                }
                            }
                            dispatch_group_leave(group);
                        }];
                    }
                }
            }
            
            dispatch_group_notify(group, dispatch_get_main_queue(), ^{
                if (complete) {
                    complete(urls);
                }
            });
            
        } else {
            if (complete) {
                complete(nil);
            }
        }
    });
}


- (void)didSelectPost {
    // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
    // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
    NSLog(@"%@", self);
    
    [super didSelectPost];
    [self.extensionContext completeRequestReturningItems:@[] completionHandler:nil];
}

- (NSArray *)configurationItems {
    // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
    
    SLComposeSheetConfigurationItem *item_01 = [[SLComposeSheetConfigurationItem alloc] init];
    item_01.title = @"第一个选项 title";
    item_01.value = @"第一个选项 value";
    item_01.valuePending = YES;
    item_01.tapHandler = ^{
        NSLog(@"选中第一个选项");
    };
    
    SLComposeSheetConfigurationItem *item_02 = [[SLComposeSheetConfigurationItem alloc] init];
    item_02.title = @"第二个选项 title";
    item_02.value = @"第二个选项 value";
    item_02.valuePending = YES;
    item_02.tapHandler = ^{
        NSLog(@"选中第二个选项");
    };
    
    return @[item_01, item_02];
}

@end
