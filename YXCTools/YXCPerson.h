//
//  YXCPerson.h
//  YXCTools
//
//  Created by GGT on 2020/4/17.
//  Copyright © 2020 GGT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXCPerson : NSObject

@property (nonatomic, copy) NSString *name; /**< 姓名 */
@property (nonatomic, assign) NSInteger age; /**< 年龄 */
@property (nonatomic, assign) CGFloat height; /**< 身高 */

@end

NS_ASSUME_NONNULL_END
