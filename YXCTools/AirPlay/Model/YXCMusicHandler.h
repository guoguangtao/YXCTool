//
//  YXCMusicHandler.h
//  YXCTools
//
//  Created by lbkj on 2021/10/23.
//  Copyright © 2021 GGT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXCAudioModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YXCMusicHandler : NSObject

#pragma mark - Property

@property (nonatomic, strong) NSArray<YXCAudioModel *> *musics; /**< 所有音乐 */


#pragma mark - Method

+ (instancetype)shareInstance;

@end

NS_ASSUME_NONNULL_END
