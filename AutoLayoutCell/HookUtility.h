//
//  HookUtility.h
//  AutoLayoutCell
//
//  Created by taishu on 2019/11/6.
//  Copyright © 2019 taishu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HookUtility : NSObject
+ (void)swizzlingInClass:(Class)cls originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

@end

NS_ASSUME_NONNULL_END
