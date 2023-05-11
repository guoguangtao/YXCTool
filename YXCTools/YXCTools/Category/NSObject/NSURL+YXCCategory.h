//
//  NSURL+YXCCategory.h
//  MacCommand
//
//  Created by guogt on 2023/5/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (YXCCategory)

/// URL 解析对象
@property (nonatomic, nullable, strong, readonly) NSURLComponents *yxc_components;
/// URL 参数字典
@property (nonatomic, nullable, strong, readonly) NSDictionary *yxc_queryItemsDictionary;

@end

NS_ASSUME_NONNULL_END
