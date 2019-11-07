//
//  UIViewController+Statistics.m
//  AutoLayoutCell
//
//  Created by taishu on 2019/11/6.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "UIViewController+Statistics.h"
#import "HookUtility.h"
#import "UserStatisticsManager.h"

@implementation UIViewController (Statistics)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzleSelector = @selector(swizzle_viewWillAppaer:);
        [HookUtility swizzlingInClass:[self class] originalSelector:originalSelector swizzledSelector:swizzleSelector];
        
        SEL originalSelector2 = @selector(viewWillDisappear:);
        SEL swizzleSelector2 = @selector(swizzle_viewWillDisappear:);
        [HookUtility swizzlingInClass:[self class] originalSelector:originalSelector2 swizzledSelector:swizzleSelector2];
    });
}

- (void)swizzle_viewWillAppaer:(BOOL)animated {
    //插入需要替换的代码，这里是统计时长
    [self insert_viewWillAppear];
    [self swizzle_viewWillAppaer:animated];
}

- (void)swizzle_viewWillDisappear:(BOOL)animated {
    [self insert_viewWillDisappear];
    [self swizzle_viewWillDisappear:animated];
}

//进入页面统计
- (void)insert_viewWillAppear {
    //获取页面事件ID
    NSString *pageID = [self pageEventID:YES];
    if (pageID) {
        [UserStatisticsManager sendEventToServer:pageID];
    }
}

//离开页面统计
- (void)insert_viewWillDisappear {
    //获取页面事件ID
    NSString *pageID = [self pageEventID:NO];
    if (pageID) {
        [UserStatisticsManager sendEventToServer:pageID];
    }
}

- (NSString *)pageEventID:(BOOL)enterPage {
    NSDictionary *dic = [UserStatisticsManager getDicFromPlist];
    NSString *className = NSStringFromClass([self class]);
    return dic[className][@"PageEventIDs"][enterPage ? @"Enter" : @"Leave"];
}

@end
