//
//  HookUtility.m
//  AutoLayoutCell
//
//  Created by taishu on 2019/11/6.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "HookUtility.h"
#import <objc/runtime.h>

@implementation HookUtility
+ (void)swizzlingInClass:(Class)cls originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector {
    Class class = cls;
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzleMethod = class_getInstanceMethod(class, swizzledSelector);
    
    //class_addMethod是给类class添加一个新的方法，方法的名字是originalSelector，方法的实现是第三个参数method_getImplementation(swizzleMethod)，方法的参数是第四个参数method_getTypeEncoding(swizzleMethod)
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    //如果返回是NO，说明该类中已经存在这个方法，如果是YES，说明不存在
    if (didAddMethod) {
        //不存在originalSelector，则用swizzledSelector替换。class_replaceMethod1、类中没有被替代的方法，执行class_addMethod; 2、类中有要被替代的方法，执行method_setImplementation；
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        //存在originalSelector，则交换方法的实现
        method_exchangeImplementations(originalMethod, swizzleMethod);
    }
    
}
@end
