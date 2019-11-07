
//
//  UIControl+Statistics.m
//  AutoLayoutCell
//
//  Created by taishu on 2019/11/7.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "UIControl+Statistics.h"
#import "HookUtility.h"
#import "UserStatisticsManager.h"

@implementation UIControl (Statistics)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(sendAction:to:forEvent:);
        SEL swizzleSelector = @selector(swizzle_sendAction:to:forEvent:);
        [HookUtility swizzlingInClass:[self class] originalSelector:originalSelector swizzledSelector:swizzleSelector];
    });
}

- (void)swizzle_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    [self insert_action:action to:target forEvent:event];
    [self swizzle_sendAction:action to:target forEvent:event];
}

//添加点击统计
- (void)insert_action:(SEL)action to:target forEvent:event {
    NSString *eventID = nil;
    if ([[[event allTouches] anyObject] phase] == UITouchPhaseEnded) {
        NSString *actionString = NSStringFromSelector(action);
        NSString *targetName = NSStringFromClass([target class]);
        eventID = [UserStatisticsManager getDicFromPlist][targetName][@"ControlEventIDs"][actionString];
    }
    if (eventID != nil) {
        [UserStatisticsManager sendEventToServer:eventID];
    }
}


@end
