//
//  YXCAudioModel.h
//  YXCTools
//
//  Created by lbkj on 2021/10/20.
//  Copyright © 2021 GGT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXCAudioModel : NSObject

#pragma mark - Property

@property (nonatomic, copy) NSString *musicName; /**< 音乐名称 */
@property (nonatomic, copy) NSURL *musicUrl; /**< 音乐播放连接 */
@property (nonatomic, copy) NSURL *musicImage; /**< 音乐图片 */


#pragma mark - Method

@end

NS_ASSUME_NONNULL_END
