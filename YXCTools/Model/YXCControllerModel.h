//
//  YXCControllerModel.h
//  YXCTools
//
//  Created by GGT on 2020/9/19.
//  Copyright © 2020 GGT. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 控制器信息模型
@interface YXCControllerModel : NSObject

#pragma mark - Property

@property (nonatomic, copy) NSString *className;        /**< 需要跳转的控制器名称 */
@property (nonatomic, copy) NSString *title;            /**< 控制器标题 */
@property (nonatomic, strong) NSDictionary *parameter;  /**< 参数 */


#pragma mark - Method

/// 创建 model
/// @param className 控制器类名
/// @param title 控制器标题
/// @param parameter 参数
+ (instancetype)modelWithClassName:(NSString *)className
                             title:(NSString *)title
                         parameter:(NSDictionary *)parameter;

@end
