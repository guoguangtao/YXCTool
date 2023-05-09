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
@property (nonatomic, nullable, strong, readonly) NSURLComponents *components;
/// URL 链接方案
@property (nonatomic, nullable, copy, readonly) NSString *scheme;
/// URL 用户名
@property (nonatomic, nullable, copy, readonly) NSString *user;
/// URL 密码
@property (nonatomic, nullable, copy, readonly) NSString *password;
/// URL 域名
@property (nonatomic, nullable, copy, readonly) NSString *host;
/// URL 端口号
@property (nonatomic, nullable, strong, readonly) NSNumber *port;
/// URL 路径
@property (nonatomic, nullable, copy, readonly) NSString *path;
/// URL 参数字符串
@property (nonatomic, nullable, copy, readonly) NSString *query;
/// URL 参数数组
@property (nonatomic, nullable, strong, readonly) NSArray<NSURLQueryItem *> *queryItems;
/// URL 参数字典
@property (nonatomic, nullable, strong, readonly) NSDictionary *queryItemsDictionary;

@end

NS_ASSUME_NONNULL_END
